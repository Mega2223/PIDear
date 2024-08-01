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
            return self.p * self.kp + self.i * self.ki - self.d * self.kd
        end
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
            while error < self.wrap / 2 do
                error = error + self.wrap
            end

            self.d = error - self.p
            self.p = error
            self.i = self.i + error
            return self.p * self.kp + self.i * self.ki - self.d * self.kd
        end
    }
end
