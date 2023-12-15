function step(char, value = 0)
	char = only(char)
	ascii = Int(char)
	value += ascii
	value *= 17
	value %= 256
	return value
end

function HASH(string, value = 0)
	if length(string) == 1
		return step(string, value)
	else
		return HASH(string[2:end], step(first(string), value))
	end
end

function sum_sol(lenses)
	sol = 0
	for i in 0:255
		for (k, lens) in enumerate(lenses[i])
			sol += (i + 1) * k * lens[2]
		end
	end
	return sol
end

function main()
	line = readlines("input")[1]
	commands = split(line, ',')
	sol = 0
	lenses = Dict(i => [] for i in 0:255)
	for comm in commands
		add = true
		if '=' ∈ comm
			(label, value) = split(comm, '=')
			value = parse(Int8, value)
		else
			label = comm[1:end-1]
			add = false
		end
		if add
			if length(findall(x -> first(x) == label, lenses[HASH(label)])) > 0
				indices = findall(x -> first(x) == label, lenses[HASH(label)])
				lenses[HASH(label)][indices] .= [(label, value)]
			else
				push!(lenses[HASH(label)], (label, value))
			end
		else
			indices = findall(x -> first(x) == label, lenses[HASH(label)])
			deleteat!(lenses[HASH(label)], indices)
		end
	end
	sol = sum_sol(lenses)
	print("Solution: $sol")
end

main()