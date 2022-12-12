metatable = {__index = function(t, i) t[i] = {} return t[i] end}

spots = setmetatable({}, metatable)

for y, row in require(script.ModuleScript):split("\n") do
	for x, height in row:split("") do
		if height == "S" then startSpot = Vector2.new(x, y) end
		if height == "E" then endSpot = Vector2.new(x, y) end
		height = (height == "S" and "a" or height == "E" and "z" or height):byte() - 96
		spots[x][y] = height
	end
end

states = setmetatable({[endSpot.X] = {[endSpot.Y] = true}}, metatable)

steps = 0
minHeight = 26

function checkPosition(x, y)
	local height = spots[x][y]
	for direction = 1, 4 do
		local r, i = 1, 0 for _ = 1, direction do r, i = -i, r end
		local x2, y2 = x + r, y + i
		if states[x2][y2] then continue end
		
		local height2 = spots[x2][y2]
		if not height2 then continue end
		
		local stepUp = false
		
		if height == minHeight and height2 == minHeight - 1 then
			print(height2)
			minHeight = height2
			stepUp = true
		end
		
		if height <= height2 + 1 then
			local part = Instance.new("Part")
			part.Position = Vector3.new(x2, height2 / 2, y2)
			part.Size = Vector3.new(1, height2, 1)
			part.Color = stepUp and Color3.new(1, 1, 1) or Color3.new(1)
			part.Anchored = true
			part.Parent = workspace.Terrain
			states[x2][y2] = true
		end
	end
end

repeat
	local finish = false
	
	local states2 = {}
	for x, line in states do
		local line2 = {}
		for y in line do
			line2[y] = true
		end
		states2[x] = line2
	end
	
	for x, line in states2 do
		for y in line do
			if spots[x][y] == 1 then finish = true break end
			
			checkPosition(x, y)
		end
		if finish then break end
	end
	if finish then break end
	
	steps += 1
	
	task.wait()
until nil

print(steps)
