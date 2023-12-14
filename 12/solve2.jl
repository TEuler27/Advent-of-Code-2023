using StatsBase

function is_compatible(string, groups)
	if count(x -> (x == '?') || (x == '#'), string) < sum(groups)
		return false
	end
	(vals, lens) = rle(collect(string))
	i = 0
	finished = true
	for (k, (val, len)) in enumerate(zip(vals, lens))
		if val == '#'
			i += 1
			if (i > length(groups))
				return false
			else
				if k+1 ≤ length(vals)
					if (vals[k+1] != '?') && (len != groups[i])
						return false
					end
				else
					if len != groups[i]
						return false
					end
				end
			end
		elseif val == '?'
			finished = false
			break
		end
	end
	if i < length(groups) && finished
		println(string, groups)
		return false
	end
	return true
end

function count_block(block, groups)
	if !is_compatible(block, groups)
		return 0
	end
	if '?' ∉ block
		return 1
	end
	if is_bad(block)
		return pre_brute_force(block, groups)
	else
		case1 = replace(block, '?' => '.'; count = 1)
		case2 = replace(block, '?' => '#'; count = 1)
		return count_block(case1, groups) + count_block(case2, groups)
	end
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

function is_bad(string)
	return length(findall(x -> x == '?', string)) > 10
end

function pre_brute_force(string, groups)
	marks = findall(x -> x == '?', string)
	index_to_swap = marks[floor(Int8, length(marks) / 2)]
	case1 = string[1:index_to_swap-1] * '#' * string[index_to_swap+1:end]
	case2 = string[1:index_to_swap-1] * '.' * string[index_to_swap+1:end]
	total = 0
	if is_compatible(case1, groups)
		total += solve_input(case1, groups)
	end
	if is_compatible(case2, groups)
		total += solve_input(case2, groups)
	end
	return total
end

function main()
	lines = readlines("input")
	num_strings = length(lines)
	total = 0
	for (i, line) in enumerate(lines)
		(data, pieces) = split(line, ' ')
		data = String(data)
		pieces = parse.(Int8,(split(pieces, ',')))
		data = join(repeat([data], 5), '?')
		pieces = repeat(pieces, 5)
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
		println("String $i/$num_strings calculated: total is $total")
	end
	println("Solution: $total")
end

main()