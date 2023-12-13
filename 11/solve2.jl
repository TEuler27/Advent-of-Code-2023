using Combinatorics

function distance(i1, i2)
	(x1, y1) = i1
	(x2, y2) = i2
	return abs(x2 - x1) + abs(y2 - y1) 
end

function count_in_between(h, k, list)
	return length(filter(x -> h < x < k, list))
end

function main()
	sol = 0
	lines = readlines("input")
	mapp = reduce(vcat, permutedims.(collect.(lines)))
	galaxies_indices = findall(x -> x == '#', mapp)
	columns_to_enlarge = findall(x -> x == 1, all(x -> x == '.', mapp, dims = 1))
	columns_to_enlarge = [x[2] for x in columns_to_enlarge]
	rows_to_enlarge = findall(x -> x == 1, all(x -> x == '.', mapp, dims = 2))
	rows_to_enlarge = [x[1] for x in rows_to_enlarge]
	sort!(rows_to_enlarge)
	sort!(columns_to_enlarge)
	for (i1, i2) in Combinatorics.combinations(galaxies_indices, 2)
		i1 = Tuple(i1)
		i2 = Tuple(i2)
		to_add = 0
		to_add += distance(i1, i2)		
		to_add += 999999 * count_in_between(min(i1[1], i2[1]), max(i1[1], i2[1]), rows_to_enlarge)
		to_add += 999999 * count_in_between(min(i1[2], i2[2]), max(i1[2], i2[2]), columns_to_enlarge)
		sol += to_add
	end
	print("Solution: ", sol)
end

main()