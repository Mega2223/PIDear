function genFactors(level)
    f0 = math.max(1,math.floor(level))/2
    f1 = level/f0
    return f1,f0
end

function getOtherFactor(level,f0)
    return level/f0
end

function genIntegerFactors(level,limit)
    if limit == null then limit = level end
    local i = 1
    local minError = 1/0
    local c = 0;local b = 0
    while i <= limit do
        local j = 0
        while j <= limit do
            local err = math.abs((i*j)-level)
            if err<minError then
                minError = err
                c = i
                b = j
            end
            j = j + 1
        end
        i = i + 1       
    end
    return math.floor(c),math.floor(b),minError
end
