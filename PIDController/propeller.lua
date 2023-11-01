controller = peripheral.wrap("bottom")

function setOutput(side,level)
    controller.setAnalogOutput(side,level)    
end

PROP = {
    setLevel = function(self,level)
        level = math.max(0,math.min(level,15))
        setOutput(self.side,15-level)
    end,
    getLevel = function(self) return controller.getAnalogOutput(self.side) end
    ,
    new = function(self,sideName)
        return {
            setLevel = self.setLevel,
            getLevel = self.getLevel,
            side = sideName
        }
    end
}

SW = PROP:new("right")
NE = PROP:new("left")
SE = PROP:new("front")
NW = PROP:new("back")

function zeroAll()
    SW:setLevel(0)
    NE:setLevel(0)
    SE:setLevel(0)
    NW:setLevel(0)
end

zeroAll()
return {SW,NE,SE,NW}

