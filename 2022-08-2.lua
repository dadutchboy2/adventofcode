trees = require(script.ModuleScript)

rows = trees:split("\n")

height, width = #rows, rows[1]:len()

trees = {}

for y, row in rows do
	treeRow = {}
	
	for x, tree in row:split("") do
		treeRow[x] = tonumber(tree)
	end
	
	trees[y] = treeRow
end

local maxValue = 0

for x = 1, width do
	for y = 1, height do
		local tree = trees[y][x]
		
		local values = {0, 0, 0, 0}
		
		for i = 1, 4 do
			local w = i % 2 == 1 and x or y
			
			while i <= 2 and w < width or i > 2 and w > 1 do
				w += i <= 2 and 1 or -1
				
				values[i] += 1
				
				if trees[i % 2 == 1 and y or w][i % 2 == 1 and w or x] >= tree then break end
			end
		end
		
		local value = 1
		
		for _, value2 in values do
			value *= value2
		end
		
		maxValue = math.max(maxValue, value)
	end
end

print(maxValue)
