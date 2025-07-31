--[[
MIT License

Copyright (c) 2025 Mavletberdin Rustam

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local M = {}
local mt = {}

function M.new(vec)
    setmetatable(vec, mt)
    vec.add = M.add
    vec.sub = M.sub
    vec.mul = M.mul
    vec.scalar_mul = M.scalar_mul
    vec.scalar_div = M.scalar_div

    vec.dot = M.dot
    vec.len = M.len
    vec.norm = M.norm
    vec.equal = M.equal

    return vec
end

function M.tostring(v)
    local res = "{"
    for key, value in pairs(v) do
        if type(value) == "number" then
            if type(key) == "number" then
                res = res .. " " .. value
            else
                res = res .. " " .. key .. ":" .. value
            end
        end
    end
    res = res .. " }"
    return res
end

function M.unm(v)
    local res = {}
    for key, value in pairs(v) do
        if type(value) == "number" then
            res[key] = -value
        end
    end
    return M.new(res)
end

function M.add(a, b)
    local res = {}
    for key, value in pairs(a) do
        if type(value) == "number" then
            res[key] = a[key] + b[key]
        end
    end
    return M.new(res)
end

function M.sub(a, b)
    local res = {}
    for key, value in pairs(a) do
        if type(value) == "number" then
            res[key] = a[key] - b[key]
        end
    end
    return M.new(res)
end

function M.mul(a, b)
    if type(b) == "number" then
        return M.scalar_mul(a, b)
    elseif type(b) == "table" then
        return M.dot(a, b)
    else
        error("scalar or vector expected")
    end
end

function M.scalar_mul(a, b)
    if type(b) ~= "number" then
        error("scalar expected")
    end
    local res = {}
    for key, value  in pairs(a) do
        if type(value) == "number" then
            res[key] = value * b
        end
    end
    return M.new(res)
end

function M.scalar_div(a, b)
    if type(b) ~= "number" then
        error("scalar expected")
    end
    local res = {}
    for key, value  in pairs(a) do
        if type(value) == "number" then
            res[key] = value / b
        end
    end
    return M.new(res)
end

function M.dot(a, b)
    if type(b) ~= "table" then
        error("table expected")
    end
    local res = 0
    for key, value in pairs(a) do
        if type(value) == "number" then
            res = res + (a[key] * b[key])
        end
    end
    return res
end

function M.len(v)
    local res = 0
    for _, value in pairs(v) do
        if type(value) == "number" then
            res = res + value * value
        end
    end
    return math.sqrt(res)
end

function M.norm(v)
    local l = v:len()
    local res = {}
    for key, value in pairs(v) do
        if type(value) == "number" then
            res[key] = value / l
        end
    end
    return M.new(res)
end

function M.equal(a, b)
    for key, value in pairs(a) do
        if type(value) == "number" and a[key] ~= b[key] then
            return false
        end
    end
    return true
end

-- setting metatable
mt.__unm = M.unm
mt.__add = M.add
mt.__sub = M.sub
mt.__mul = M.mul
mt.__div = M.scalar_div
mt.__eq  = M.equal
mt.__tostring = M.tostring

return M
