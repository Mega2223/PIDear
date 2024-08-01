require('pid')
require('vectormath')

local function start(controller, sleep_time)
    while true do
        sleep(sleep_time)
    end
end

function QuadcopterController(control_fun)
    return {
        start = start,
        xPID = PID(1.0, 0.1, 1.0),
        yPID = PID(1.0, 0.1, 1.0),
        zPID = PID(1.0, 0.1, 1.0),
        rollPID = PID_loop(0.25, 0.1, 00.3, 2 * math.pi),
        pitchPID = PID_loop(0.25, 0.01, 0.3, 2 * math.pi),
        yawPID = PID_loop(0.25, 0.01, 0.3, 2 * math.pi),
        control_fun = control_fun
    }
end
