con = {
    P = 0, I = 0, D = 0,
    add = function(self,p,i,d)
        self.P = self.P + p
        self.I = self.I + i
        self.D = self.D + d
    end,
    reset = function(self)
        self.P = 0; self.I = 0; self.D = 0;
    end,
    calculate = function(self,w1,w2,w3)
        return (self.P * w1) + (self.I * w2) + (self.D * w3)
    end
    ,
    new = function(self)
        return{
        P = 0, I = 0, D = 0,
        add=self.add, reset = self.reset,
        calculate = self.calculate
        }
    end,
    
}
