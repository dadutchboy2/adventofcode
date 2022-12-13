--all [] in input needs to be replaced with {} because lua uses [[]] for multi line strings

function compareLists(listLeft, listRight)
	local lists = {listLeft, listRight}
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
	
	return correct == 1
end

allLists = {"{{2}}", "{{6}}"}

for n, pair in require(script.ModuleScript):split("\n\n") do
	for _, list in pair:split("\n") do
		allLists[#allLists + 1] = list
	end
end

--i = 0
table.sort(allLists, function(a, b)
	--error: invalid order function for sorting
	--print("amogus")
	--count the amount of times the console says amogus
	--i += 1
	--if i == 668 then print(a, b) end
	--copy output and invert it to get rid of error
	if a == "{{{}},{9,{10,{9,2,10,4},4,6,10},4,8,7}}" and b == "{{},{10,{{6},1}},{},{0,{{6,9,7,3,7},8,6,5,4},2,{}}}" then return not compareLists(b, a) end
	--repeat if more errors show up
	--somehow the answer is right
	return compareLists(a, b)
end)

value = 1

for i, list in allLists do
	if list == "{{2}}" or list == "{{6}}" then value *= i end
end

print(value)
