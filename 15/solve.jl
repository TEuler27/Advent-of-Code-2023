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

function main()
	line = readlines("input")[1]
	commands = split(line, ',')
	sol = 0
	for comm in commands
		sol += HASH(comm)
	end
	println("Solution: $sol")
end

main()