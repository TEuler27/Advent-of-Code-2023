function has_neighbour_symbol(i, j, data)
    for h in -1:1
        for k in -1:1
            if !(h == 0 && k == 0)
                if (i+h, j+k) in keys(data)
                    if !isdigit(data[(i+h, j+k)])
                        return true
                    end
                end
            end
        end
    end
    return false
end

function has_two_neighbour_numbers(i, j, data)
    nums = []
    for h in -1:1
        for k in -1:1
            if !(h == 0 && k == 0)
                if (i+h, j+k) in keys(data)
                    if isdigit(data[(i+h, j+k)])
                        num, l, u = retrieve_number(i+h, j+k, data)
                        if !((num, l, u) in nums)
                            push!(nums, (num, l, u))
                        end
                    end
                end
            end
        end
    end
    if length(nums) == 2
        return true, nums
    end
    return false, []
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
    return parse(Int64, num), j-left+1, j+right-1
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
sol = []
for key in keys(data)
    i, j  = key
    if !isdigit(data[(i, j)])
        cond, nums = has_two_neighbour_numbers(i, j, data)
        if cond
            push!(sol, nums[1][1]*nums[2][1])
        end
    end
end
print(sum(sol))