modem_manager = {
	new = function (self,location,id)
		ret = {
			location = location,
			id = id,
		}
		ret.peripheral = peripheral.wrap(ret.location)
		ret.broadcast = function(self,frequency,message)
			self.peripheral.transmit(frequency,frequency,self.id..":"..message)
		end
		return ret
	end
}