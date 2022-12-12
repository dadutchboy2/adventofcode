totalStrength = 0
i, x = 0, 1

function cycle()
	i += 1
	if i % 40 == 20 then
		totalStrength += i * x
	end
end

for _, line in require(script.ModuleScript):split("\n") do
	if line == "noop" then
		cycle()
	else
		cycle()
		cycle()
		x += line:split(" ")[2]
	end
	
	if i > 220 then break end
end

print(totalStrength)
