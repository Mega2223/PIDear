propellers = require("propeller")
require("controller")

function updateController(self,coords,rot,deltaP,deltaR)

end

NW.controller = con:new(updateController)
NE.controller = con:new(updateController)
SW.controller = con:new(updateController)
SE.controller = con:new(updateController)

reader = peripheral.wrap("top")

function getCoords(coords,rotation,deltaC,deltaR)
    local d = reader.getWorldspacePosition()
    return {d['x'],d['y'],d['z']}
end

function calculateFirstDerivatives(c1,c2,r1,r2)
    retC = {}
    retR = {}
    for i = 1,3 do
        retC[i] = c2[i] - c1[i]
        retR[i] = r2[i] - r1[i]
    end
    return retC, retR
end

function getRotation()
    local r = reader.getRotation()
    return {r['roll'],r['pitch'],r['yaw']}
end

local previousCoords = getCoords()
local previousRotation = getRotation()

while true do
    local coords = getCoords()
    local rotation = getRotation()
    local deltaC, deltaR = calculateFirstDerivatives(
        previousCoords,coords,previousRotation,rotation
    )
    
    --print("V="..deltaC[2])
    
    for i = 1,4 do
        act = propellers[i]
        control = act.controller
        error = - 40 - coords[2]
        deltaError = -deltaC[2]
        control.P = (error)
        control.I = control.I + (error)
        control.D = (deltaError)
        f = control:calculate(1/3,0.03,2/3)
        --act.controller:performLogic()
        act:setLevel(f)
        --print(i.."; [v]:"..control.D .. " [p]: " .. control.P)
    end 
    print("P="..propellers[1].controller.P.." i="..propellers[1].controller.I.." d="..propellers[1].controller.D)
    print("rest: " .. math.floor(f))
    os.sleep(1)
    previousCoords = coords
    previousRotation = rotation
end
