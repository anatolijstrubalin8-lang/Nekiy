function ser(a,b)
    return a + b
end

print(ser(1,2))

local replicated = game:GetService('ReplicatedStorage')

b = require(replicated:WaitForChild('Shared'):WaitForChild('choto'))

b:init()

