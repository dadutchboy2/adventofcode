state = {head = Vector2.new(0, 0), tails = {}}
trail = setmetatable({}, {__index = function(t, i) t[i] = {} return t[i] end})

for i = 1, 9 do
	local tail = Vector2.new(0, 0)
	state.tails[i] = tail
end

directions = {R = Vector2.new(1, 0), U = Vector2.new(0, 1), L = Vector2.new(-1, 0), D = Vector2.new(0, -1)}

function moveTails()
	for i, tail in state.tails do
		local head = i == 1 and state.head or state.tails[i - 1]
		
		if (tail - head).Magnitude < 2 then continue end
		
		tail = tail:Lerp(head, 0.6)
		
		state.tails[i] = Vector2.new(math.round(tail.X), math.round(tail.Y))
	end
end

function addTrail()
	local tail = state.tails[9]
	trail[tail.X][tail.Y] = true
end

for _, line in require(script.ModuleScript):split("\n") do
	local direction, amount = unpack(line:split(" "))
	direction, amount = directions[direction], tonumber(amount)
	
	for _ = 1, amount do
		state.head += direction
		moveTails()
		addTrail()
	end
end

positions = 0

for _, line in trail do
	for _ in line do
		positions += 1
	end
end

print(positions)
