trees = require(script.ModuleScript)

rows = trees:split("\n")

height, width = #rows, rows[1]:len()

visibleTrees = 0

trees = {}

for y, row in rows do
	treeRow = {}
	
	for x, tree in row:split("") do
		treeRow[x] = tonumber(tree)
	end
	
	trees[y] = treeRow
end

visibleTrees = setmetatable({}, {__index = function(t, i) t[i] = {} return t[i] end})

for _, sign in {false, true} do
	local dimX = sign and height or width
	local dimY = sign and width or height
	
	for x = 1, dimX do
		for _, sign2 in {false, true} do
			local maxTree = -1
			
			for y = sign2 and dimY or 1, sign2 and 1 or dimY, sign2 and -1 or 1 do
				local tree = trees[sign and x or y][sign and y or x]
				
				if maxTree >= tree then continue end
				
				visibleTrees[sign and y or x][sign and x or y] = true
				maxTree = tree
			end
		end
	end
end

totalTrees = 0

for _, visibleTreeCol in visibleTrees do
	for _ in visibleTreeCol do
		totalTrees += 1
	end
end

print(totalTrees)
