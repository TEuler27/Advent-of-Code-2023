using StatsBase

global cardsordered = "AKQT98765432J" 
global othervalues = "AKQT98765432"

function set_jack_value(hand)
	if occursin('J', hand)
		if length(filter(x -> x != 'J', hand)) > 0
			moda = mode(filter(x -> x != 'J', hand))
			return replace(hand, 'J' => moda)
		else
			return hand
		end
	else
		return hand
	end
end

function hand_type(hand)
	unique = Set(hand)
	if length(unique) == 5
		return 1
	elseif length(unique) == 4
		return 2
	elseif length(unique) == 3
		istris = false
		for card in hand
			if length(filter(x -> x == card, hand)) == 3
				istris = true
				break
			end
		end
		if istris
			return 4
		else
			return 3
		end
	elseif length(unique) == 2
		isfull = false
		for card in hand
			if length(filter(x -> x == card, hand)) == 3
				isfull = true
				break
			end
		end
		if isfull
			return 5
		else
			return 6
		end
	else
		return 7
	end
end

function sort_hand(hand1, hand2)
	hand_type1 = hand_type(set_jack_value(hand1))
	hand_type2 = hand_type(set_jack_value(hand2))
	if hand_type1 > hand_type2
		return true
	elseif hand_type1 < hand_type2
		return false
	else
		for (card1, card2) in zip(hand1, hand2)
			if findfirst(card1, cardsordered)[1] < findfirst(card2, cardsordered)[1]
				return true
			elseif findfirst(card1, cardsordered)[1] > findfirst(card2, cardsordered)[1]
				return false
			end
		end
	end
end

lines = readlines("input")
hands = []
bids = []
for line in lines
	(hand, bid) = split(line, ' ')
	push!(hands, hand)
	push!(bids, parse(Int64, bid))
end
data = collect(zip(hands, bids))
sort!(data, lt = (x, y) -> sort_hand(x, y), by = x -> x[1], rev = true)
sol = 0
for (i, tup) in enumerate(data)
	global sol += i * tup[2]
end
print(sol)
