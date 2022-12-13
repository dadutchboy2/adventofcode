--all [] in input needs to be replaced with {} because lua uses [[]] for multi line strings

value = 0

for n, pair in require(script.ModuleScript):split("\n\n") do
	local lists = pair:split("\n")
	local correct
	
	for i = 1, math.max(lists[1]:len(), lists[2]:len()) do
		for a = 1, 2 do
			local b = a == 1 and 2 or 1
			local ten1, ten2 = tonumber(lists[a]:sub(i, i + 1)), tonumber(lists[b]:sub(i, i + 1))
			local char1, char2 = lists[a]:sub(i, i + (ten1 and 1 or 0)), lists[b]:sub(i, i + (ten2 and 1 or 0))
			
			if char1 == "," then continue end
			
			if char1 == "{" then
				if char2 ~= "{" then
					local list2 = lists[b]
					list2 = list2:sub(1, i - 1) .. "{" .. char2 .. "}" .. list2:sub(i + (ten2 and 2 or 1))
					lists[b] = list2
					break
				end
			elseif char1 == "}" then
				if char2 ~= "}" then
					correct = a
					break
				end
			else
				local number1 = tonumber(char1)
				local number2 = tonumber(char2)
				
				if number2 == nil then continue end
				
				if number1 < number2 then
					correct = a
					break
				end
			end
		end
		
		if correct then break end
	end
	
	if correct == 1 then value += n end
end

print(value)
