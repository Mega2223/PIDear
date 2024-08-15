local function asString(self)
    --´return 'PID CONTROLLER:\nkP=' .. self.kp .. ' kI=' .. self.ki .. ' kD=' .. self.kd ..
    --    '\nP=' .. self.p .. ' I=' .. self.i .. ' D=' .. self.d .. '\nLAST= ' ..
    --    (self.p * self.kp + self.i * self.ki - self.d * self.kd)
    return string.format('kP=%.2f kI=%.2f kD=%2f\np=%.2f i=%.2f d=%.2f	LAST=%.2f', self.kp, self.ki, self.kd, self.p,
        self.i, self.d,
        -(self.p * self.kp + self.i * self.ki + self.d * self.kd)
    )
end

function PID(kp, ki, kd)
    return {
        p = 0,
        i = 0,
        d = 0,
        kp = kp,
        ki = ki,
        kd = kd,
        update = function(self, error)
            self.d = error - self.p
            self.p = error
            self.i = self.i + error
            return -(self.p * self.kp + self.i * self.ki + self.d * self.kd)
        end,
        asString = asString
    }
end

function PID_loop(kp, ki, kd, wrapLoc)
    return {
        p = 0,
        i = 0,
        d = 0,
        wrap = wrapLoc,
        kp = kp,
        ki = ki,
        kd = kd,
        update = function(self, error)
            while error > self.wrap / 2 do
                error = error - self.wrap
            end
            while error < -self.wrap / 2 do
                error = error + self.wrap
            end

            self.d = error - self.p
            self.p = error
            self.i = self.i + error
            return -(self.p * self.kp + self.i * self.ki + self.d * self.kd)
        end,
        asString = asString
    }
end
