assigmentList = require(script.ModuleScript)

assignmentPairs = assigmentList:split("\n")

matches = 0

for _, assignmentPair in assignmentPairs do
	local assignments = assignmentPair:split(",")
	
	for i, assignment in assignments do
		assignments[i] = NumberRange.new(unpack(assignment:split("-")))
	end
	
	--if not (assignments[1].Min <= assignments[2].Min and assignments[1].Max >= assignments[2].Max or
	--	assignments[1].Min >= assignments[2].Min and assignments[1].Max <= assignments[2].Max) then continue end
	
	local min = math.max(assignments[1].Min, assignments[2].Min)
	local max = math.min(assignments[1].Max, assignments[2].Max)
	
	if min > max or max < min then continue end
	
	matches += 1
end

print(matches)
