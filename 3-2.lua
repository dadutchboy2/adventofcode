inventory = require(script.ModuleScript)

rucksacks = inventory:split("\n")

totalPriority = 0

function addPriority(character)
	local byte = character:byte()
	
	if byte >= 97 and byte <= 122 then
		totalPriority += byte - 96
	else
		totalPriority += byte - 65 + 27
	end
end

local currentRucksack = {}

for i, rucksack in rucksacks do
	local iMod = (i - 1) % 3 + 1
	
	currentRucksack[iMod] = rucksack
	
	if iMod ~= 3 then continue end
	
	for _, character in currentRucksack[1]:split("") do
		if not currentRucksack[2]:match(character) or not currentRucksack[3]:match(character) then continue end
		
		addPriority(character)
		
		break
	end
	
	currentRucksack = {}
end

print(totalPriority)
