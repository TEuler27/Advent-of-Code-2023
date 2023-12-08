data = Dict()
sourcedest = Dict()
lines = readlines("input")
for (i, line) in enumerate(lines)
	if i == 1
		_, seeds = split(line, ": ")
		seeds_to_read = parse.(Int64, split(seeds, ' '))
		global seeds = []
		for (k, seed) in enumerate(seeds_to_read)
			if k % 2 == 1	
				push!(seeds, (seed, seed + seeds_to_read[k+1]))
			end
		end
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
location = 0
skipped = 0
total = 0
for (seedstart, seedend) in seeds
	global seed = seedstart
	global skippable = 0
	while seed + skippable <= seedend
		global seed += skippable
		global x = seed
		global source = "seed"
		global dest = "seed"
		while dest != "location"
			global dest = sourcedest[source]
			for (sourcestart, sourceend, deststart) in data[source]
				if sourcestart <= x && x <= sourceend
					if skippable != 0
						global skippable = min(skippable, sourceend - x)
					else
						global skippable = sourceend - x
					end
					global x = deststart + x - sourcestart
					break
				end
			end
			global source = dest
		end		
		global seed += 1
		if location == 0
			global location = x
		end
		if location != 0 && x < location
			global location = x
		end 
	end
end
print(location)
