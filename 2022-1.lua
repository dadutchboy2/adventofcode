calorieList = require(script.ModuleScript)

local lines = string.split(calorieList, "\n")

cariedCalories = setmetatable({}, {__index = function() return 0 end})

breaks = 1

for _, line in lines do
	if line == "" then breaks += 1 continue end
	
	cariedCalories[breaks] += tonumber(line)
end

table.sort(cariedCalories, function(a, b)
	return a > b
end)

print(cariedCalories[1] + cariedCalories[2] + cariedCalories[3])
