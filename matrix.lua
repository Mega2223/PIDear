local function times(mat1, scalar)
    local r1, c1 = mat1.r, mat1.c
    if type(scalar) == "number" then
        local ret = Matrix(r1, c1)
        for m = 1, r1 do
            for n = 1, c1 do
                ret.data[m][n] = mat1.data[m][n] * scalar
            end
        end
        return ret
    elseif scalar.type == "matrix" then
        local mat2 = scalar
        local ret = Matrix(mat1.r, mat2.c)
        for r = 1, ret.r do
            for c = 1, ret.c do
                for k = 1, mat1.c do
                    ret.data[r][c] = ret.data[r][c] + (mat1.data[r][k] * mat2.data[k][c])
                end
            end
        end
        return ret
    end
end

local function toString(mat)
    local data = mat.data;
    local r, c = mat.r, mat.c
    local ret = ''
    for m = 1, r do
        ret = ret .. '['
        for n = 1, c do
            ret = ret .. ' ' .. data[m][n]
        end
        ret = ret .. ' ]\n'
    end
    return ret
end

local function transpose(mat)
    ret = Matrix(mat.c, mat.r)
    for i = 1, mat.r do
        for j = 1, mat.c do
            ret.data[j][i] = mat.data[i][j]
        end
    end
    return ret
end

function Identity(n)
    local mat = Matrix(n, n)
    for i = 1, n do mat.data[i][i] = 1 end
    return mat
end

function Matrix(r, c)
    local data = {}
    for m = 1, r do
        data[m] = {}
        for n = 1, c do
            data[m][n] = 0
        end
    end
    return {
        data = data,
        r = r,
        c = c,
        toString = toString,
        type = "matrix",
        times = times,
        transpose = transpose
    }
end
