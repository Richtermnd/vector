# Vector

Simple single-file library for vectors.

## Usage
Just copy it to ur project.

### Creating vector

```lua
-- vector with named components
v = vector.new {x = 1, y = 2, z = 3}
-- vector with unnamed components
v = vector.new {1, 2, 3}
```

### Operations
```lua
v1 = vector.new {1, 2, 3}
v2 = vector.new {4, 5, 6}

-- addition/substitution
vector.add(v1, v2) -- with function
v1:add(v2)         -- with method
v1 + v2            -- with overloaded operator

vector.sub(v1, v2) -- with function
v1:sub(v2)         -- with method
v1 - v2            -- with overloaded operator

--- dot product
vector.dot(v1, v2) -- with function
v1:dot(v2)         -- with method
v1 * v2            -- with overloaded operator

--- scalar multiplication
vector.scalar_mul(v1, n) -- with function
v1:scalar_mul(n)         -- with method
v1 * n                   -- with overloaded operator

--- scalar division
vector.scalar_div(v1, n) -- with function
v1:scalar_div(n)         -- with method
v1 / n                   -- with overloaded operator

-- length (only by function or method, overloaded operator will be too implicit)
vector.len(v1)
v1:len()

-- norm
vector.norm(v1)
v1:norm()
```
