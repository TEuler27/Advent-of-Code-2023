using Combinatorics

function enlarge(mapp)
	columns_to_enlarge = findall(x -> x == 1, all(x -> x == '.', mapp, dims = 1))
	columns_to_enlarge = [x[2] for x in columns_to_enlarge]
	rows_to_enlarge = findall(x -> x == 1, all(x -> x == '.', mapp, dims = 2))
	rows_to_enlarge = [x[1] for x in rows_to_enlarge]
	new_mapp = Array{Any}(nothing, size(mapp)[1] + length(rows_to_enlarge), size(mapp)[2] + length(columns_to_enlarge))
	count = 0
	for row in rows_to_enlarge
		new_mapp[row + count, :] .= '.'
		count += 1
	end
	count = 0
	for column in columns_to_enlarge
		new_mapp[:, column + count] .= '.'
		count += 1
	end
	new_mapp[findall(x -> x == nothing, new_mapp)] = mapp
	return new_mapp
end

function distance(i1, i2)
	(x1, y1) = Tuple(i1)
	(x2, y2) = Tuple(i2)
	return abs(x2 - x1) + abs(y2 - y1) 
end

function main()
	sol = 0
	lines = readlines("input")
	mapp = reduce(vcat, permutedims.(collect.(lines)))
	mapp = enlarge(mapp)
	indices_galaxies = findall(x -> x == '#', mapp)
	for (g1, g2) in Combinatorics.combinations(indices_galaxies, 2)
		sol += distance(g1, g2)
	end 
	print("Solution: ", sol)
end

main()