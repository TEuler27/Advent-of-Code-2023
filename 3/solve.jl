function has_neighbour_symbol(i, j, data)
    for h in -1:1
        for k in -1:1
            if !(h == 0 && k == 0)
                if (i+h, j+k) in keys(data)
                    if data[(i+h, j+k)] != '.' && !isdigit(data[(i+h, j+k)])
                        return true
                    end
                end
            end
        end
    end
    return false
end

function retrieve_number(i, j, data)
    num = data[(i, j)]
    left = 1
    right = 1
    while true
        if (i, j-left) in keys(data)
            if isdigit(data[(i, j - left)])
                num = data[(i, j - left)] * num
                left += 1
            else
                break
            end
        else
            break
        end
    end
    while true
        if (i, j+right) in keys(data)
            if isdigit(data[(i, j + right)])
                num *= data[(i, j + right)]
                right += 1
            else
                break
            end
        else
            break
        end
    end
    return parse(Int16, num), j-left+1, j+right-1
end

lines = readlines("input")
data = Dict()
for (i, line) in enumerate(lines)
    for (j, char) in enumerate(line)
        if !(char == '.')
            data[(i, j)] = char
        end
    end
end
seen = []
sol = []
for key in keys(data)
    i, j  = key
    if !((i, j) in seen) && isdigit(data[(i, j)])
        symbol = false
        num, l, u = retrieve_number(i, j, data)
        for x in l:u
            push!(seen, (i, x))
            if has_neighbour_symbol(i, x, data)
                symbol = true
            end
        end
        if symbol
            push!(sol, num)
            continue
        end
    end
end
print(sum(sol))