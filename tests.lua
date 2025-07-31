-- Simple testing script

local vector = require('vector')

function test_equal()
    local v = vector.new({x = 1, y = 2, z = 3})
    assert(v == {x = 1, y = 2, z = 3}, "vectors are not equal")
end

function test_unm()
    local v = vector.new({x = 1, y = 2, z = -3})
    assert(-v == {x = -1, y = -2, z = 3}, "vectors are not equal")
end

function test_add()
    local v1 = vector.new({x = 1, y = 2})
    local v2 = vector.new({x = 3, y = 4})
    local v = v1 + v2
    assert(v.x == 4, "bad x: expected 4, got " .. v.x)
    assert(v.y == 6, "bad y: expected 6, got " .. v.y)
end

function test_sub()
    local v1 = vector.new({x = 1, y = 2})
    local v2 = vector.new({x = 3, y = 4})
    local v = v1 - v2
    assert(v.x == -2, "bad x: expected 4, got " .. v.x)
    assert(v.y == -2, "bad y: expected 6, got " .. v.y)
end

function test_dot()
    local v1 = vector.new({x = 1, y = 3, z = -5})
    local v2 = vector.new({x = 4, y = -2, z = -1})
    local v = v1 * v2
    assert(v == 3, "expected 3 got " .. v)
end

function test_scalar_mul()
    local v = vector.new({x = 1, y = 3, z = -5})
    v = v * 2
    local expected = vector.new{x = 2, y = 6, z = -10}
    assert(v == expected, v, expected)
end

function test_len()
    local v = vector.new({x = 3, y = 4})
    local l = v:len()
    assert(l == 5, "expected: 5 got " .. l)
end

function test_len()
    local v = vector.new({x = 3, y = 4})
    local norm = v:norm()
    assert(norm.x == 0.6, "bad x: expected 0.6, got " .. norm.x)
    assert(norm.y == 0.8, "bad y: expected 0.8, got " .. norm.y)
end


local failed = false
for key, value in pairs(_G) do
    if string.match(key, "^test_*") and type(value) == "function" then
        print("Running: " .. key)
        local ok, err = pcall(value)
        if not ok then
            print("\tFAILED: " .. err)
            failed = true
        else
            print("\tPASS")
        end
    end
end

if failed then
    print("=== FAILED === ")
else
    print("=== PASSED === ")
end
