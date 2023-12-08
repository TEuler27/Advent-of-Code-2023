lines = readlines("input")
time = split(lines[1], ':')[2]
distance = split(lines[2], ':')[2]
time = filter(x -> !isspace(x), time)
distance = filter(x -> !isspace(x), distance)
time = parse(Int64, time)
distance = parse(Int64, distance)
delta = time ^ 2 - 4 * distance
if delta >= 0
	x1 = (time - sqrt(delta)) / 2
	x2 = (time + sqrt(delta)) / 2
	lower = floor(Int64, x1 + 1)
	upper = ceil(Int64, x2 - 1)
	global sol = (upper - lower + 1)
else
	print("BOH")
end
print(sol)