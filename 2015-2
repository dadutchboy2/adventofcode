totalPaper = 0
totalRibbon = 0

for _, presentDimensions in require(script.ModuleScript):split("\n") do
	local size = presentDimensions:split("x")
	local paper, volume = 0, 1
	local sideAreas, sidePerimeters = {}, {}
	
	for i = 1, 3 do
		volume *= size[i]
		
		for i2 = 1, 3 do
			if i == i2 then continue end
			
			local area = size[i] * size[i2]
			local perimeter = size[i] * 2 + size[i2] * 2
			local id = i + i2 - 2
			
			paper += area
			sideAreas[id] = area
			sidePerimeters[id] = perimeter
		end
	end
	
	totalPaper += paper + math.min(unpack(sideAreas))
	totalRibbon += math.min(unpack(sidePerimeters)) + volume
end

print(totalPaper, totalRibbon)
