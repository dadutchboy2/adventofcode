rawValves = {}

for _, valveData in require(script.ModuleScript):split("\n") do
	local dataA, dataB = unpack(valveData:split("; "))
	local index, rate = unpack(dataA:split("="))
	rawValves[index:split(" ")[2]] = {rate = tonumber(rate), leads = (function(first, ...) return {first:split(" ")[5], ...} end)(unpack(dataB:split(", ")))}
end

function distance(a, b)
	local leads = rawValves[a].leads
	local i = 1
	if table.find(leads, b) then return i end
	repeat
		i += 1
		local newLeads = {}
		for _, newA in leads do
			local leads = rawValves[newA].leads
			if table.find(leads, b) then return i end
			for _, lead in leads do
				newLeads[#newLeads + 1] = lead
			end
		end
		leads = newLeads
	until nil
end

valves = {}

for index, rawValve in rawValves do
	if rawValve.rate == 0 and index ~= "AA" then continue end
	
	local leads = {}
	
	for index2, rawValve2 in rawValves do
		if rawValve2.rate == 0 or index2 == index then continue end
		
		leads[index2] = distance(index, index2)
	end
	
	local valve = {rate = rawValve.rate, leads = leads}
	
	valves[index] = valve
end

paths = {"AA_0__0"}

i = 0

function wait()
	i += 1
	if i % 10000 == 0 then task.wait() end
end

for _ = 0, 30 do
	local newPaths = {}
	
	for _, path in paths do
		local data = path:split("_")
		local openedValves = data[3]:split(";")
		for i, openedValve in openedValves do
			if i == #openedValves then continue end
			data[4] += valves[openedValve].rate
		end
		if data[2] + 0 > 0 then
			data[2] -= 1
			newPaths[#newPaths + 1] = table.concat(data, "_") wait()
			continue
		end
		if not data[3]:find(data[1]) then
			data[3] ..= data[1] .. ";"
			newPaths[#newPaths + 1] = table.concat(data, "_") wait()
			continue
		end
		local valve = valves[data[1]]
		local moved for lead, steps in valve.leads do
			if data[3]:find(lead) then continue end
			local newData = {lead, steps - 1, data[3], data[4]}
			newPaths[#newPaths + 1] = table.concat(newData, "_") wait()
			moved = true
		end
		if not moved then newPaths[#newPaths + 1] = table.concat(data, "_") wait() end
	end
	
	paths = newPaths
end

maxRelease = 0

for _, path in paths do
	maxRelease = math.max(maxRelease, path:split("_")[4] + 0)
end

print(maxRelease)
