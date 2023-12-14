using StatsBase

function is_compatible(string, groups)
	(vals, lens) = rle(collect(string))
	i = 0
	for (val, len) in zip(vals, lens)
		if val == '#'
			i += 1
			if (i > length(groups)) || len != groups[i]
				return false
			end
		end
	end
	if i < length(groups)
		return false
	end
	return true
end

function count_block(block, groups)
	if '?' ∉ block
		if is_compatible(block, groups)
			return 1
		else
			return 0
		end
	end
	case1 = replace(block, '?' => '.'; count = 1)
	case2 = replace(block, '?' => '#'; count = 1)
	return count_block(case1, groups) + count_block(case2, groups)
end

function partial_sum(groups)
	return map(enumerate(groups)) do (i, x)
		sum(first(groups, i)) + i-1
	end
end

function solve_input(string, groups)
	if '.' ∉ string
		return count_block(string, groups)
	end
	all = split(string, '.')
	(block, extra) = first(all), join(all[2:end], '.')
	sums = partial_sum(groups)
	total = 0
	if '#' ∉ block
		total += solve_input(extra, groups)
	end
	doable = filter(x -> x ≤ length(block), sums)
	if length(doable) == 0 && '#' ∈ block
		return 0
	end
	for i in 1:length(doable)
		total += count_block(block, groups[1:i]) * solve_input(extra, groups[i+1:end])
	end
	return total
end

function main()
	lines = readlines("input")
	total = 0
	for line in lines
		(data, pieces) = split(line, ' ')
		data = String(data)
		pieces = parse.(Int8,(split(pieces, ',')))
		(vals, lens) = rle(collect(data))
		data = ""
		for (val, len) in zip(vals, lens)
			if val == '.'
				data *= '.'
			else
				data *= val^len
			end
		end
		if data[1] == '.'
			data = data[2:end]
		end
		if last(data) == '.'
			data = first(data, length(data)-1)
		end
		total += solve_input(data, pieces)
	end
	println("Solution: $total")
end

main()