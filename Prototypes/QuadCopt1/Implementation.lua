motor_N = peripheral.wrap('electric_motor_0')
motor_E = peripheral.wrap('electric_motor_1')
motor_S = peripheral.wrap('electric_motor_2')
motor_W = peripheral.wrap('electric_motor_3')

function sense()
    coord = ship.getWorldspacePosition()
    return coord.x, coord.y, coord.z,
        ship.getRoll(), ship.getPitch(), ship.getYaw()
end

local last_control = ''
function control(e1, e2, e3, e4)
    last_control = string.format('CONTROL: %2d %2d %2d %2d', e1, e2, e3, e4)
    motor_N.setSpeed(e1)
    motor_E.setSpeed(-e2)
    motor_S.setSpeed(e3)
    motor_W.setSpeed(-e4)
end

function output(controller)
    term.clear()
    term.setCursorPos(1, 1)
    --print('xPID=\n'..controller.xPID:asString())
    print('yPID=\n' .. controller.yPID:asString())
    --print('zPID=\n'..controller.zPID:asString())
    print('\nrPID=\n' .. controller.rollPID:asString())
    print('\npiPID=\n' .. controller.pitchPID:asString())
    print('\n' .. last_control)
end

require('quadcopter')
controller = QuadcopterController(sense, control, output)
controller.target.y = 0
controller.yPID.i = -100
controller:start(.35)
