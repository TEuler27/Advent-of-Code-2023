lines = readlines("input")
nums = Dict("one" => "1", "two" => '2', "three" => '3', "four" => "4", "five" => '5', "six" => '6', "seven" => '7', "eight" => '8', "nine" => '9')
sol = Vector{Int8}([])
for line in lines
    num = ""
    for (k, letter) in enumerate(line)
        if isdigit(letter)
            num = num * letter
      	    break
        else
            is_found = false
            for i in 2:4
            	if k+i <= length(line)
	            	if line[k:k + i] in keys(nums)
	            	    num = num * nums[line[k:k + i]]
	            	    is_found = true
	            	    break
	            	end
            	end
            end
            if is_found
                break
            end
        end
    end
    for (k, letter) in enumerate(Iterators.reverse(line))
        if isdigit(letter)
            num = num * letter
      	    break
        else
            is_found = false
            for i in 2:4
            	if i <= k
	            	if line[length(line) - k:length(line) - k + i] in keys(nums)
	            	    num = num * nums[line[length(line) - k:length(line) - k + i]]
	            	    is_found = true
	            	    break
	            	end
            	end
            end
            if is_found
                break
            end
        end
    endss
    num = parse(Int8, num)
    push!(sol, num)
end
print(sum(sol))
