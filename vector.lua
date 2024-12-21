local function dot(vecA, vecB)
    return vecA.x * vecB.x + vecA.y * vecB.y + vecA.z * vecB.z
end

local function magnitude(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
end

local function normal(vec)
    return vec:times(1.0 / vec:magnitude())
end

local function times(vec, amount)
    local ret = Vec3(0, 0, 0)
    if type(amount) == "number" then
        ret.x = vec.x * amount; ret.y = vec.y * amount; ret.z = vec.z * amount
    elseif amount.type == "vec3" then
        ret.x = vec.x * amount.x; ret.y = vec.y * amount.y; ret.z = vec.z * amount.z
    elseif amount.type == "matrix" then
        return amount:times(vec)
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
        amount = amount:flip()
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
    local ret = Matrix(4, 1)
    ret:set(1, 1, vec.x)
    ret:set(1, 1, vec.y)
    ret:set(1, 1, vec.z)
    ret:set(1, 1, 1)
    return ret
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
        asMatrix = asMatrix,
        type = "vec3"
    }
end
