lines = readlines("input")
times = split(split(lines[1], ':')[2], ' ')
distances = split(split(lines[2], ':')[2], ' ')
times = strip.(times)
distances = strip.(distances)
filter!(x -> length(x) != 0, times)
filter!(x -> length(x) != 0, distances)
times = parse.(Int64, times)
distances = parse.(Int64, distances)
sol = 1
for (time, distance) in zip(times, distances)
	delta = time ^ 2 - 4 * distance
	if delta >= 0
		x1 = (time - sqrt(delta)) / 2
		x2 = (time + sqrt(delta)) / 2
		lower = floor(Int64, x1 + 1)
		upper = ceil(Int64, x2 - 1)
		global sol *= (upper - lower + 1)
	else
		print("BOH")
	end
end
print(sol)