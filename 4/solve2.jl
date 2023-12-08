global cache = Dict()

function count_winning_scratchcards(id, cards)
    tot_cards = length(keys(cards))
    i = 0
    winning, nums = cards[id]
    for num in nums
        if num in winning && id + i <= tot_cards
            i += 1
        end
    end
    if i == 0
        if !(id in keys(cache))
            global cache[id] = 0
        end
        return 0
    end
    if id in keys(cache)
        return cache[id]
    else
        further_winned = 0
        for k in 1:i
            winned = count_winning_scratchcards(id+k, cards)
            global cache[id+k] = winned
            further_winned += winned 
        end
        global cache[id] = further_winned + i
        return i + further_winned
    end
end

lines = readlines("input")
global points = 0
cards = Dict()
for line in lines
	winning, nums = split(line, " | ")
    id, winning = split(winning, ": ")
    id = split(id, " ")
    id = last(id)
    id = parse(Int16, id)
    winning = split(winning, ' ')
    nums = split(nums, ' ')
    filter!(x -> x != "", winning)
    filter!(x -> x != "", nums)
    nums = parse.(Int64, nums)
    winning = parse.(Int64, winning)
    cards[id] = (winning, nums)
end
for id in 1:209
    global points += count_winning_scratchcards(id, cards)
end
print(points+209)
