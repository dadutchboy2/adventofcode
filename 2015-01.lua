directions = require(script.ModuleScript)

endFloor = 0

for i, direction in directions:split("") do
	endFloor += direction == "(" and 1 or direction == ")" and -1
	
	if not basement and endFloor == -1 then
		basement = i
	end
end

print(endFloor, basement)
