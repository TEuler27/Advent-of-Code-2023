lines = readlines("input")
data = Dict()
for (i, line) in enumerate(lines)
	if i == 1
		global directions = line
	elseif i > 2
		(start, ends) = split(line, " = ")
		(endl, endr) = split(replace(ends, Dict('(' => "", ')' => "")...), ", ")
		data[start] = (endl, endr)		
	end
end
steps = 0
node = "AAA"
while node != "ZZZ"
	global steps += 1
	mod_steps = steps % length(directions)
	if mod_steps == 0
		mod_steps = length(directions)
	end
	dir = directions[mod_steps]
	if dir == 'L'
		global node = data[node][1]
	else
		global node = data[node][2]
	end
end
print(steps)