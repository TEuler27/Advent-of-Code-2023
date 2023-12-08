lines = readlines("input")
sol = []
for line in lines
    is_sol = true
    colors = []
    nums = Dict()
    game, datas = split(line, ": ")
    _, id = split(game, ' ')
    id = parse(Int8, id)
    for extraction in split(datas, "; ")
        for data in split(extraction, ", ")
            num, color = split(data, " ")
            num = parse(Int8, num)
            if !(color in colors)
                push!(colors, color)
                nums[color] = num
            else
                if nums[color] < num
                    nums[color] = num
                end
            end
        end
    end
    power = 1
    for color in colors
    	power *= nums[color]
    end
    push!(sol, power)
end
print(sum(sol))
