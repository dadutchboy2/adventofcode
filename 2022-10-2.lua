image = {}
i, x = 0, 1

function cycle()
	i += 1
	image[i] = math.abs(x + 1 - ((i - 1) % 40 + 1)) <= 1
end

for _, line in require(script.ModuleScript):split("\n") do
	if line == "noop" then
		cycle()
	else
		cycle()
		cycle()
		x += line:split(" ")[2]
	end
end

crt = "\n"

for i = 1, 240 do
	crt ..= (image[i] and "#" or ".") .. (i % 40 == 0 and "\n" or "")
end

print(crt)
