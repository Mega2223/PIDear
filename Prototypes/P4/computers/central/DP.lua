
DP = {
    setLevel = function(self,major,minor)
		self.levelMajor = major; self.levelMinor = minor;
		self.modem.transmit(self.channel,self.channel,major.."::".. minor)
    end,
	getLevel = function(self)
		return self.levelMajor, self.levelMinor
	end
	,
    new = function(self,channel,modemPeripheral)
        return {
            levelMajor = 0,
			levelMinor = 0,
			getLevel = self.getLevel,
			setLevel = self.setLevel,
			modem = modemPeripheral,
			channel = channel
        }
    end
}
