terminal = require(script.ModuleScript)

lines = terminal:split("\n")

currentDirectory = {}
tree = {}

function getDir()
	local directory = tree
	
	for _, name in currentDirectory do
		directory = directory[name]
	end
	
	return directory
end

function changeDir(statement)
	if statement == "/" then
		currentDirectory = {}
		return
	end
	
	if statement == ".." then
		currentDirectory[#currentDirectory] = nil
		return
	end
	
	currentDirectory[#currentDirectory + 1] = statement
end

for _, line in lines do
	local parts = line:split(" ")
	
	if parts[1] == "$" then
		if parts[2] ~= "cd" then continue end
		
		changeDir(parts[3])
		
		continue
	end
	
	local size = tonumber(parts[1])
	
	getDir()[parts[2]] = size or {}
end

sizes = {}

function searchSize(directory)
	local size = 0
	
	for name, data in directory do
		size += type(data) == "number" and data or searchSize(data)
	end
	
	sizes[#sizes + 1] = size
	
	return size
end

usedSize = searchSize(tree)

totalSize = 0

for _, size in sizes do
	totalSize += size
end

freeSize = 70000000 - usedSize
requiredSize = 30000000 - freeSize
minSize = totalSize

for _, size in sizes do
	if not (size <= minSize and size >= requiredSize) then continue end
	
	minSize = size
end

print(minSize)
