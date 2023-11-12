require("controller")
require("usefulmath")
require("stringparser")
require("DP")

desiredPosition = {-15,-45,-15}
desiredRotation = {0,0,0}

reader = peripheral.wrap("top")
modem = peripheral.find("modem")

NE = con:new(); NE.name = "NE"; NE.eng = DP:new(1,modem);
NW = con:new(); NW.name = "NW"; NW.eng = DP:new(2,modem);
SE = con:new(); SE.name = "SE"; SE.eng = DP:new(3,modem);
SW = con:new(); SW.name = "SW"; SW.eng = DP:new(4,modem);

R = con:new(); P = con:new();

controllers = {NE,NW,SE,SW}

previousCoords = reader.getWorldspacePosition()
previousRotation = reader.getRotation()

local function clamp(var,min,max)
 return math.max(min,math.min(var,max))
end

local function setEngine(engineID,level)
	local d = level*2
	local a = math.max(math.min(d,15),0)
	local b = math.max(0,math.min(15,d - a))
	controllers[engineID].eng:setLevel(a,b)
end

local function updateRotationPIDS(rotation,angularSpeed)
	local RERR = rotation['yaw'] - desiredRotation[1]
	local PERR = rotation['pitch'] - desiredRotation[3]
	R.P = RERR
	R.I = R.I + RERR
	R.D = angularSpeed['yaw']
	P.P = PERR
	P.I = P.I + PERR
	P.D = angularSpeed['pitch']
	print('Y -> ' .. R.P .. ', ' .. R.I .. ', ' .. R.D)
	print('P -> ' .. P.P .. ', ' .. P.I .. ', ' .. P.D)
	
end

local function calculateRotationPID(id,wP,wI,wD)
	if id == 1 then --northeast
		return -R:calculate(wP,wI,wD) - P:calculate(wP,wI,wD)
	elseif id == 2 then --northwest
		return R:calculate(wP,wI,wD) - P:calculate(wP,wI,wD)
	elseif id == 3 then --southeast
		return -R:calculate(wP,wI,wD) + P:calculate(wP,wI,wD)
	elseif id == 4 then --southwest
		return R:calculate(wP,wI,wD) + P:calculate(wP,wI,wD)
	end
end

local function addToIntegrals (value)
	local i = 0 while i < 4 do i = i + 1 controllers[i].I = controllers[i].I + value end
end

local function updateDesiredAngle(currentCoords)
 local bound = math.pi / 120
 local dif = {
  (currentCoords['x'] - desiredPosition[1]),
  (currentCoords['z'] - desiredPosition[3])
 }
 --print(dif[1])
 desiredRotation[3] = clamp(-dif[2]/400,-bound,bound)
 desiredRotation[1] = clamp(dif[1]/400,-bound,bound)
 
 print("DIF -> " .. dif[1] .. ", " .. dif[2])
 print("DR -> " .. desiredRotation[1] .. ", " .. desiredRotation[3])
end

setEngine(1,0)
setEngine(2,0)
setEngine(3,0)
setEngine(4,0)

--addToIntegrals(4000)
local r = reader.getRotation()
print('r:'..r.roll..' p:'..r.pitch..' y:'..r.yaw)

--if true then return nil end

local function doLogic()
	term.clear() term.setCursorPos(1,1)
	local currentCoords = reader.getWorldspacePosition(); local currentRotation = reader.getRotation()
	print('COORDS: ' .. currentCoords.x .. ", " .. currentCoords.y .. "," .. currentCoords.z .. "\n")
 updateDesiredAngle(currentCoords)
	local currentSpeed, currentAngularSpeed = calculateDerivatives(previousCoords,currentCoords,previousRotation,currentRotation)
	local error = -57 - currentCoords.y
	updateRotationPIDS(currentRotation,currentAngularSpeed)
	local i = 1; while i <= 4 do
		local act = controllers[i]
		act.P = error
		act.I = math.max(0,act.I + error)
		act.D = -currentSpeed.y
		if i == 1 then print("PID -> " .. act.P .. ", " .. act.I .. ", " .. act.D) end
		local amount = act:calculate(1/10,1/600,3)
  print()
		amount = amount + (
    calculateRotationPID(i,1/2,0,4/3))
		setEngine(i,amount)
		print("["..i.."]->"..amount)
		i = i + 1
	end
	previousCoords = currentCoords
	previousRotation = currentRotation
end

peripheral.wrap("left").open(2223)
os.startTimer(1/10)
shouldClose = false
while not shouldClose do
 event, a,b,c,d,e,f,g = os.pullEvent()
	if event == 'timer' then
  doLogic()
  os.startTimer(1/5)
 elseif event == 'modem_message' then
  shouldClose = true
 end
end

setEngine(1,0)
setEngine(2,0)
setEngine(3,0)
setEngine(4,0)
