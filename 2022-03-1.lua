inventory = require(script.ModuleScript)

rucksacks = inventory:split("\n")

totalPriority = 0

function addPriority(character)
	local byte = character:byte()
	
	if byte >= 97 and byte <= 122 then
		totalPriority += byte - 96
	else
		totalPriority += byte - 64 + 26
	end
end

for _, rucksack in rucksacks do
	local length = rucksack:len()
	
	local compartment1, compartment2 = rucksack:sub(1, length / 2), rucksack:sub(length / 2 + 1, -1)
	
	for _, character in compartment2:split("") do
		if not compartment1:match(character) then continue end
		
		addPriority(character)
		
		break
	end
end

print(totalPriority)
