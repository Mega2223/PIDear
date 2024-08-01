function dotProduct(vecA, vecB)
    return vec3(vecA.x * vecB.x, vecA.y * vecB.y, vecA.z * vecB.z)
end

function getMagnitude(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
end

function normalize(vec)
    vec:multiply(1.0/vec.getMagnitude())
end

function multiply(vec, amount)
    if type(amount) == "number" then
        vec.x = vec.x * amount; vec.y = vec.y * amount; vec.z = vec.z * amount
    else
        vec.x = vec.x * amount.x; vec.y = vec.y * amount.y; vec.z = vec.z * amount.z
    end
end

function add(vec, amount)
    if type(amount) == "number" then
        vec.x = vec.x + amount; vec.y = vec.y + amount; vec.z = vec.z + amount
    else
        vec.x = vec.x + amount.x; vec.y = vec.y + amount.y; vec.z = vec.z + amount.z
    end
end

function flip(vec)
    vec.x = -vec.x; vec.y = - vec.y; vec.z = - vec.z
end

function subtract(vec, amount)
    if type(amount) =="number" then
        vec:add(-amount)
    else
        amount:flip()
        vec:add(amount)
        amount:flip()
    end
end

function clone(vec)
    return vec3(vec.x,vec.y,vec.z)
end

function vec3(x,y,z)
    return {
        x = x, y = y, z = z, size = 3,
        getMagnitude = getMagnitude,
        dotProduct = dotProduct,
        clone = clone, add = add, multiply = multiply, subtract = subtract, normalize = normalize, flip = flip
        
    }
end