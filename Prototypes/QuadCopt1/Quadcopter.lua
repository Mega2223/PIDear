require('pid')
require('vectormath')

local function start(controller, sleep_time)
    while true do
        local x, y, z, roll, pitch, yaw = controller.sensing_fun()

        local xPID = controller.xPID:update(x - controller.target.x)
        local yPID = controller.yPID:update(y - controller.target.y)
        local zPID = controller.zPID:update(z - controller.target.z)

        local thrust, roll_cmd, pitch_cmd, yaw_cmd =
            -yPID,
            -zPID,
            -xPID,
            0

        local e1, e2, e3, e4 = controller.influenceMatrix:translate(roll_cmd, pitch_cmd, yaw_cmd)
        controller.control_fun(e1, e2, e3, e4)
        sleep(sleep_time)
    end
end

local function influenceMatrix()
    -- The influence matrix dictates the relation
    -- between the relative rotation variables and the 4 engines
    return {
        R = { .5, -5, .5, -.5 },
        P = { .5, .5, -.5, -.5 },
        Y = { -.5, .5, .5, -.5 },
        translate = function(self, roll, pitch, yaw)
            return
                self.R[1] * roll + self.P[1] * pitch + self.Y[1] * yaw,
                self.R[2] * roll + self.P[2] * pitch + self.Y[2] * yaw,
                self.R[3] * roll + self.P[3] * pitch + self.Y[3] * yaw,
                self.R[4] * roll + self.P[4] * pitch + self.Y[4] * yaw
        end
    }
end

function QuadcopterController(sensing_fun, control_fun, output_fun)
    return {
        start = start,
        xPID = PID(1.0, 0.1, 1.0),
        yPID = PID(1.0, 0.1, 1.0),
        zPID = PID(1.0, 0.1, 1.0),
        rollPID = PID_loop(0.25, 0.1, 00.3, 2 * math.pi),
        pitchPID = PID_loop(0.25, 0.01, 0.3, 2 * math.pi),
        yawPID = PID_loop(0.25, 0.01, 0.3, 2 * math.pi),
        sensing_fun = sensing_fun,
        control_fun = control_fun,
        output_fun = output_fun,
        influenceMatrix = influenceMatrix(),
        target = {
            x = 0, y = 0, z = 0, roll = 0, pitch = 0, yaw = 0
        }
    }
end
