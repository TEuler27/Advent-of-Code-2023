lines = readlines("input")
colors = ["green", "red", "blue"]
nums = Dict("green" => 13, "red" => 12, "blue" => 14)
sol = []
for line in lines
    is_sol = true
    game, datas = split(line, ": ")
    _, id = split(game, ' ')
    id = parse(Int8, id)
    for extraction in split(datas, "; ")
        for data in split(extraction, ", ")
            num, color = split(data, " ")
            num = parse(Int8, num)
            if !(color in colors)
                is_sol = false
                break
            end
            if nums[color] < num
                is_sol = false
                break
            end
        end
        if !is_sol
            break
        end
    end
    if is_sol
        push!(sol, id)
    end
end
print(sum(sol))
