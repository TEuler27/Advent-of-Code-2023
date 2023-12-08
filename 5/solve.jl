data = Dict()
sourcedest = Dict()
lines = readlines("input")
for (i, line) in enumerate(lines)
	if i == 1
		_, seeds = split(line, ": ")
		global seeds = parse.(Int64, split(seeds, ' '))
		continue
	end
	if length(line) != 0
		if occursin("map",line)
			sd, _ = split(line, ' ')
			loc = split(sd, '-')
			global source = loc[1]
			global dest = loc[3]
			sourcedest[source] = dest
		else
			deststart, sourcestart, range = parse.(Int64, split(line, ' '))
			if source in keys(data)
				push!(data[source], (sourcestart, sourcestart + range - 1, deststart))
			else
				data[source] = [(sourcestart, sourcestart + range - 1, deststart)]
			end 
		end
	end
end
locations = []
for seed in seeds
	global x = seed
	global source = "seed"
	global dest = "seed"
	while dest != "location"
		global dest = sourcedest[source]
		for (sourcestart, sourceend, deststart) in data[source]
			if sourcestart <= x && x <= sourceend
				global x = deststart + x - sourcestart
				break
			end
		end
		global source = dest
	end
	push!(locations, x)
end
print(minimum(locations))
