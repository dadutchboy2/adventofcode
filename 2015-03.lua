directions = {
	[">"] = Vector2.new(1, 0),
	["^"] = Vector2.new(0, 1),
	["v"] = Vector2.new(0, -1),
	["<"] = Vector2.new(-1, 0),
}

houses = setmetatable({[0] = {[0] = true}}, {__index = function(t, i) t[i] = {} return t[i] end})
position = Vector2.new()
position2 = Vector2.new()

for i, instruction in require(script.ModuleScript):split("") do
	if i % 2 == 1 then
		position += directions[instruction]
		houses[position.X][position.Y] = true
	else
		position2 += directions[instruction]
		houses[position2.X][position2.Y] = true
	end
end

count = 0

for _, row in houses do
	for _, house in row do
		count += 1
	end
end

print(count)
