metatable = {__index = function(t, i) t[i] = {} return t[i] end}
notair = setmetatable({}, metatable)
voidHeight = 0

function placeRock(vector1 : Vector2, vector2 : Vector2)
	for x = math.min(vector1.X, vector2.X), math.max(vector1.X, vector2.X) do
		for y = math.min(vector1.Y, vector2.Y), math.max(vector1.Y, vector2.Y) do
			notair[x][y] = true
			voidHeight = math.min(voidHeight, y)
		end
	end
end

for _, path in require(script.ModuleScript):split("\n") do
	local lastVector
	for _, coordinates in path:split(" -> ") do
		local vector = (Vector2.new(unpack(coordinates:split(","))) - Vector2.new(500, 0)) * Vector2.new(1, -1)
		if lastVector then placeRock(vector, lastVector) end
		lastVector = vector
	end
end

i = 0

repeat
	local sand = Vector2.new()
	
	if notair[sand.X][sand.Y] then break end
	
	repeat
		local moved
		
		for _, candidate in {Vector2.new(0, -1), Vector2.new(-1, -1), Vector2.new(1, -1)} do
			local newSand = sand + candidate
			
			if newSand.Y <= voidHeight - 2 or notair[newSand.X][newSand.Y] then continue end
			
			sand = newSand
			moved = true
			
			break
		end
		
		if not moved then
			notair[sand.X][sand.Y] = true
			break
		end
	until nil
	
	i += 1
until nil

print(i)
