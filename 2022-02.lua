guide = require(script.ModuleScript)

lines = string.split(guide, "\n")

characterMap = {A = 1, B = 2, C = 3, X = -1, Y = 0, Z = 1}
beatMap = {3, 1, 2}

function move(move, outcome)
	local shift = outcome
	
	return (move + shift - 1) % 3 + 1
end

points = 0

for _, line in lines do
	local otherMove, outcome = unpack(string.split(line, " "))
	
	otherMove, outcome = characterMap[otherMove], characterMap[outcome]
	
	local yourMove = move(otherMove, outcome)
	
	points += yourMove + (outcome + 1) * 3
end

print(points)
