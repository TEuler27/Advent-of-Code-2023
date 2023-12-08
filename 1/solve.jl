lines = readlines("input")
sol = Vector{Int8}([])
for line in lines
    num = ""
    for letter in line
        if isdigit(letter)
            num = num * letter
      	    break
        end
    end
    for letter in Iterators.reverse(line)
    	if isdigit(letter)
        	num = num * letter
        	break
    	end
    end
    num = parse(Int8, num)
    push!(sol, num)
end
print(sum(sol))
