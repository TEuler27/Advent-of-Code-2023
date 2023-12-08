lines = readlines("input")
data = Dict()
starting_nodes = []
for (i, line) in enumerate(lines)
	if i == 1
		global directions = line
	elseif i > 2
		(start, ends) = split(line, " = ")
		(endl, endr) = split(replace(ends, Dict('(' => "", ')' => "")...), ", ")
		data[start] = (endl, endr)
		if last(start) == 'A'
			push!(starting_nodes, start)
		end		
	end
end
list_steps = []
for node in starting_nodes
	steps = 0
	while last(node) != 'Z'
		steps += 1
		mod_steps = steps % length(directions)
		if mod_steps == 0
			mod_steps = length(directions)
		end
		dir = directions[mod_steps]
		if dir == 'L'
			node = data[node][1]
		else
			node = data[node][2]
		end
	end
	push!(list_steps, steps)
end
print(lcm(list_steps...))