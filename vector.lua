local function dot(vecA, vecB)
    return vecA.x * vecB.x + vecA.y * vecB.y + vecA.z * vecB.z
end

local function magnitude(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
end

local function normal(vec)
    return vec:times(1.0 / vec:getMagnitude())
end

local function times(vec, amount)
    local ret = Vec3(0, 0, 0)
    if type(amount) == "number" then
        ret.x = vec.x * amount; ret.y = vec.y * amount; ret.z = vec.z * amount
    elseif amount.type == "vec3" then
        ret.x = vec.x * amount.x; ret.y = vec.y * amount.y; ret.z = vec.z * amount.z
    elseif amount.type == "matrix" then
        local data = amount.data
        ret.x = vec.x * data[1][1] + vec.y * data[1][2] + vec.z * data[1][3] + data[1][4]
        ret.y = vec.x * data[2][1] + vec.y * data[2][2] + vec.z * data[2][3] + data[1][4]
        ret.z = vec.x * data[3][1] + vec.y * data[3][2] + vec.z * data[3][3] + data[1][4]
    end
    return ret
end

local function cross(vec1, vec2)
    return Vec3(
        vec1.y * vec2.z - vec2.y * vec1.z,
        vec1.z * vec2.x - vec2.z * vec1.x,
        vec1.x * vec2.y - vec2.x * vec1.y
    )
end

local function plus(vec, amount)
    local ret = Vec3(0, 0, 0)
    if type(amount) == "number" then
        ret.x = vec.x + amount; ret.y = vec.y + amount; ret.z = vec.z + amount
    elseif amount.type == "vec3" then
        ret.x = vec.x + amount.x; ret.y = vec.y + amount.y; ret.z = vec.z + amount.z
    end
    return ret
end

local function flip(vec)
    return Vec3(-vec.x, -vec.y, -vec.z)
end

local function minus(vec, amount)
    if type(amount) == "number" then
        return vec:plus(-amount)
    elseif amount.type == "vec3" then
        amount:flip()
        return vec:plus(amount)
    end
end

local function clone(vec)
    return Vec3(vec.x, vec.y, vec.z)
end

local function asString(vec)
    return "(x=" .. vec.x .. " y=" .. vec.y .. " z=" .. vec.z .. ")"
end

local function asMatrix(vec)

end

function Vec3(x, y, z)
    return {
        x = x,
        y = y,
        z = z,
        length = 3,
        clone = clone,
        flip = flip,
        plus = plus,
        minus = minus,
        times = times,
        normal = normal,
        dot = dot,
        cross = cross,
        magnitude = magnitude,
        toString = asString,
        type = "vec3"
    }
end
