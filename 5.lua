drawing = require(script.ModuleScript)

initialState, instructions = unpack(drawing:split("\n\n"))

state = setmetatable({}, {__index = function(t, i) t[i] = {} return t[i] end}) do
	local layers = initialState:split("\n")
	local volume, width, height = initialState:len(), layers[1]:len(), #layers - 1
	local crates, stacks = (volume + 1) / 4, (width + 1) / 4
	
	for i = 1, crates - stacks do
		local crate = initialState:sub((i - 1) * 4 + 2, (i - 1) * 4 + 2)
		
		if crate == " " then crate = nil end
		
		state[(i - 1) % stacks + 1][height - math.floor((i - 1) / stacks)] = crate
	end
end

--[[
state layout:
{stack 1, stack 2, stack 3}
stack layout:
{bottom crate, ..., top crate}
]]

function moveCrates(amount, from, to)
	local layer = #state[from]
	
	local crate repeat
		crate = state[from][layer]
		if crate then break end
		layer -= 1
	until nil
	
	local crates = {}
	
	for offset = 0, amount - 1 do
		crates[(amount - 1) - offset] = state[from][layer - offset]
		state[from][layer - offset] = nil
	end
	
	local layer = #state[to]
	
	if layer ~= 0 then
		local floor repeat
			floor = state[to][layer]
			if floor then layer += 1 break end
			layer -= 1
		until nil
	else
		layer += 1
	end
	
	for offset, crate in crates do
		state[to][layer + offset] = crate
	end
end

instructionList = instructions:split("\n")

for i, instruction in instructionList do
	local words = instruction:split(" ")
	local amount = words[2] + 0
	local from = words[4] + 0
	local to = words[6] + 0
	
	moveCrates(amount, from, to)
end

local topCrates = ""

for _, stack in state do
	local layer = #stack
	
	local crate repeat
		crate = stack[layer]
		if crate then break end
		layer -= 1
	until nil
	
	topCrates ..= crate or " "
end

print(topCrates)
