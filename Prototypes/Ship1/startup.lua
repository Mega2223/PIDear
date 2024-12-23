require('geometry')

function angleDiff(a1,a2)
	a = a1 - a2;
	while a > math.pi do a = a - math.pi * 2 end
	while a < -math.pi do a = a + math.pi * 2 end
	return a
end

function turn(amount)
    a = math.max(0,math.min(15,-amount))
    b = math.max(0,math.min(15,amount))
    redstone.setAnalogOutput('left',a)
    redstone.setAnalogOutput('right',b)
end

function getRotated()
	rotMat = ship.getRotationMatrix()
	rotMat[1][4] = 0; rotMat[2][4] = 0; rotMat[3][4] = 0
	rotMat = MatFromDict(rotMat)
	return Vec3(0,0,1):times(rotMat)
end

function getRotation(from, to)
	c = from:cross(to):normal()
	a = math.acos( (from:dot(to)) / (from:magnitude() * to:magnitude()) )
	return - c:times(math.sin(a/2)):dot(Vec3(0,1,0))
end

motor = peripheral.wrap('back')
function accel(amount)
	motor.setSpeed(-amount)
end

pos = Vec3(0, 0, 0)

function navigateTo(target)
	while true do
		local nPos = ship.getWorldspacePosition()
		local vel = Vec3(nPos.x, nPos.y, nPos.z):minus(pos); vel.y = 0
		pos = Vec3(nPos.x, nPos.y, nPos.z)
		local posDiff = target:minus(pos); posDiff.y = 0
		local rotated = getRotated()
		local rotDiff = getRotation(rotated,posDiff:normal())
  local amount = rotDiff * 400
		local accelV = ( rotated:normal():dot(posDiff:normal()) ) * math.min(posDiff:magnitude() * 10,750) - ( vel:magnitude() * 100)
		print('rotDiff = ' .. math.floor(math.deg(rotDiff)))
		print('accel = ' .. accelV)
		print('vel = ' .. vel:magnitude())
		print('')
  turn(amount)
		if math.abs(rotDiff) <= math.rad(5) then
			accel(accelV)
		else
			accel(0)
		end
        os.sleep(.5)
		if posDiff:magnitude() <= 20 then break end
    end
    turn(0)
	accel(0)
	print('Done :)')
end

--navigateTo(Vec3(5000,0,2000))
