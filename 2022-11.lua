list = require(script.ModuleScript)
monkeys = {}
commonDivisor = 1

for _, monkeyData in list:split("\n\n") do
	local monkey = {business = 0}
	local lines = monkeyData:split("\n")
	monkey.items = {}
	for i, item in lines[2]:split(": ")[2]:split(", ") do
		monkey.items[i] = tonumber(item)
	end
	local formula = lines[3]:split(" = ")[2]:split(" ")
	monkey.fOperator = formula[2]
	monkey.fValue = tonumber(formula[3]) or formula[3]
	local tValue = tonumber(lines[4]:split(": ")[2]:split(" ")[3])
	monkey.tValue = tValue
	commonDivisor *= tValue
	monkey.tTrue = lines[5]:split(": ")[2]:split(" ")[4] + 1
	monkey.tFalse = lines[6]:split(": ")[2]:split(" ")[4] + 1
	monkeys[#monkeys + 1] = monkey
end

function addValue(item, fOperator, fValue)
	local value = type(fValue) == "number" and fValue or item
	return fOperator == "+" and item + value or item * value
end

function testItem(item, tValue, tTrue, tFalse)
	local monkey = monkeys[item % tValue == 0 and tTrue or tFalse]
	monkey.items[#monkey.items + 1] = item
end

for _ = 1, 10000 do
	for _, monkey in monkeys do
		for i, item in monkey.items do
			monkey.business += 1
			item = addValue(item, monkey.fOperator, monkey.fValue)
			item = item % commonDivisor
			testItem(item, monkey.tValue, monkey.tTrue, monkey.tFalse)
			monkey.items[i] = nil
		end
	end
end

table.sort(monkeys, function(a, b)
	return a.business > b.business
end)

print(monkeys[1].business * monkeys[2].business)
