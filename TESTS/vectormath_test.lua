require('vectormath')

g = vec3(10, 20, 30)

m = {
    { 0, 0, 1 },
    { 0, 1, 0 },
    { 1, 0, 0 }
}
multiplyMat(g, m)
print(vecToString(g))
