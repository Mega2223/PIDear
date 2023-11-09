--southwest
require("stringparser")
require("aritm")

local name = "SW"
local modem = peripheral.wrap("left")
modem.open(2223)

while true do
	local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
	if channel == 2223 then
		local parsed = split(message,":")
  --print(parsed[1])
		local parseds = split(parsed[2],">")
		local val = tonumber(parseds[2])
  print(val)
		if val ~= nil then
			val = 15-math.max(0,math.min(15,val))
			local a,b = genIntegerFactors(val*15,15)
			redstone.setAnalogOutput("top",a)
			redstone.setAnalogOutput("bottom",b)
			print("SETANDO SINAL PARA " .. a .. "+" .. b)
		end
	end
end
