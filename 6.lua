stream = require(script.ModuleScript)

character = 14

repeat
	local markerCheck = stream:sub(character - 13, character)
	local isMarker = true
	
	for i = 1, 13 do
		if not markerCheck:sub(i + 1, -1):match(markerCheck:sub(i, i)) then continue end
		
		isMarker = false
		break
	end
	
	if isMarker then break end
	
	character += 1
until nil

print(character)
