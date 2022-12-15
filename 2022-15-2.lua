sensors = {}

function manhDist(vector1 : Vector2, vector2 : Vector2)
	return math.abs(vector1.X - vector2.X) + math.abs(vector1.Y - vector2.Y)
end

for _, sensorData in require(script.ModuleScript):split("\n") do
	local positions = sensorData:split(": ")
	for i, position in positions do
		position = position:split(" at ")[2]
		for _ = 1, 2 do position = position:gsub(position:match("%a="), "") end
		position = Vector2.new(unpack(position:split(", ")))
		positions[i] = position
	end
	local sensorPosition, beaconPosition = unpack(positions)
	local distance = manhDist(beaconPosition, sensorPosition)
	sensors[sensorPosition] = distance
end

i = 1

--i visualised the data to get these values
for x = 2960000 - 1000, 2960000 + 1000 do
	for y = 3211000 - 1000, 3211000 + 1000 do
		local scan = Vector2.new(x, y)
		
		local same = 0
		
		for sensor, distance in sensors do
			local distance2 = manhDist(scan, sensor)
			
			if distance < distance2 then same += 1 end
		end
		
		if same == 32 then print(x * 4000000 + y) return end
		
		i += 1
		
		if i % 10000 == 0 then task.wait() print(x, y) end
	end
end
