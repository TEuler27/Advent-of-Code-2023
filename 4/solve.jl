lines = readlines("input")
points = 0
for line in lines
	winning, nums = split(line, " | ")
    _, winning = split(winning, ": ")
    winning = split(winning, ' ')
    nums = split(nums, ' ')
    filter!(x -> x != "", winning)
    filter!(x -> x != "", nums)
    nums = parse.(Int64, nums)
    winning = parse.(Int64, winning)
    i = 0
    for num in nums
        if num in winning
            i += 1
        end
    end
    if i != 0
        global points += 2^(i-1)
    end
end
print(points)
