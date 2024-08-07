function dotProduct(vecA, vecB)
    return vecA.x * vecB.x + vecA.y * vecB.y + vecA.z * vecB.z
end

function getMagnitude(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
end

function normalize(vec)
    vec:multiply(1.0 / vec:getMagnitude())
end

function multiply(vec, amount)
    if type(amount) == "number" then
        vec.x = vec.x * amount; vec.y = vec.y * amount; vec.z = vec.z * amount
    else
        vec.x = vec.x * amount.x; vec.y = vec.y * amount.y; vec.z = vec.z * amount.z
    end
end

function multiplyMat(vec, mat)
    local x = vec.x * mat[1][1] + vec.y * mat[1][2] + vec.z * mat[1][3]
    local y = vec.x * mat[2][1] + vec.y * mat[2][2] + vec.z * mat[2][3]
    local z = vec.x * mat[3][1] + vec.y * mat[3][2] + vec.z * mat[3][3]
    return vec3(x, y, z)
end

function add(vec, amount)
    if type(amount) == "number" then
        vec.x = vec.x + amount; vec.y = vec.y + amount; vec.z = vec.z + amount
    else
        vec.x = vec.x + amount.x; vec.y = vec.y + amount.y; vec.z = vec.z + amount.z
    end
end

function flip(vec)
    vec.x = -vec.x; vec.y = -vec.y; vec.z = -vec.z
end

function subtract(vec, amount)
    if type(amount) == "number" then
        vec:add(-amount)
    else
        amount:flip()
        vec:add(amount)
        amount:flip()
    end
end

function clone(vec)
    return vec3(vec.x, vec.y, vec.z)
end

function vecToString(vec)
    return "Vec3: x=" .. vec.x .. " y=" .. vec.y .. " z=" .. vec.z
end

function vec3(x, y, z)
    return {
        x = x,
        y = y,
        z = z,
        length = 3,
        getMagnitude = getMagnitude,
        dotProduct = dotProduct,
        clone = clone,
        add = add,
        multiply = multiply,
        subtract = subtract,
        normalize = normalize,
        flip = flip
    }
end
