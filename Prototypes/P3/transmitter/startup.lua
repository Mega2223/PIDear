require("modemmanager")
require("controller")
require("usefulmath")
require("stringparser")

modem = modem_manager:new("top","CTRL")
reader = peripheral.wrap("bottom")

local function updateController(controller)
	
end

local function setEngine(engineID,level)
	modem:broadcast(2223,engineID..">"..level)
end

NE = con:new(); NE.name = "NE";
NW = con:new(); NW.name = "NW";
SE = con:new(); SE.name = "SE";
SW = con:new(); SW.name = "SW";

controllers = {NE,NW,SE,SW}

previousCoords = reader.getWorldspacePosition()
previousRotation = reader.getRotation()

while true do
	local currentCoords = reader.getWorldspacePosition(); local currentRotation = reader.getRotation()
	--print(previousCoords.x .. "->" .. currentCoords.x)
	local currentSpeed, currentAngularSpeed = calculateDerivatives(previousCoords,currentCoords,previousRotation,currentRotation)
	local error = currentCoords.y - 0
	local i = 1; while i <= 4 do
		local act = controllers[i]
		act.P = error
		act.I = act.I + error
		act.D = -currentSpeed.y
		local amount = act:calculate(1/13,1/600,1/17)
		setEngine(act.name,amount)
		i = i + 1
	end
	
	previousCoords = currentCoords
	previousRotation = currentRotation
	os.sleep(1/5)
end
