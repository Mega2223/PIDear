
DPP = {
    setLevel = function(self,level)
        self.level = math.max(0,math.min(level,15))
		major = math.floor(self.level)
		local err = self.level - major
		minor = self.level + err
		self.controllerMajor.setAnalogueOutput(self.majorSide,15-major)
		self.controllerMinor.setAnalogueOutput(self.minorSide,15-minor)
		print("EMITINDO ".. 15-major .. "MAJ " .. 15-minor .. "MIN ")
    end,
	getLevel = function(self)
		return self.level
	end
	,
    new = function(self,controllerMajorSide,majorSide,controllerMinorSide,minorSide)
        return {
            setLevel = self.setLevel,
            getLevel = self.getLevel,
			level = 0,
            controllerMajorSide = controllerMajorSide,
			controllerMinorSide = controllerMinorSide,
			majorSide = majorSide,
			minorSide = minorSide,
			controllerMajor = peripheral.wrap(controllerMajorSide),
			controllerMinor = peripheral.wrap(controllerMinorSide)
        }
    end
}
