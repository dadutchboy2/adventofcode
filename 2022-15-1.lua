sensors = {}
beacons = {}

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
	if beaconPosition.Y == 2000000 then beacons[beaconPosition.X] = true end
	local localMin = sensorPosition.X - distance
	local localMax = sensorPosition.X + distance
	min = not min and localMin or math.min(min, localMin)
	max = not max and localMax or math.max(max, localMax)
end

totalScanned = 0

for x = min, max do
	local scan = Vector2.new(x, 2000000)
	
	if beacons[scan.X] then continue end
	
	local scanned = false
	
	for sensor, distance in sensors do
		if manhDist(scan, sensor) > distance then continue end
		scanned = true
		break
	end
	
	if scanned then totalScanned += 1 end
	
	if x % 10000 == 0 then task.wait() print(x) end
end

print(totalScanned)
