using IterTools

function is_sym(i, mapp, row = true)
	if !row
		mapp = permutedims(mapp)
	end
	rows, _ = size(mapp)
	for k in 1: min(i, rows - i)-1
		# print("Checking row ", i-k, " and ", i+1+k, '\n')
		if mapp[i - k, :] != mapp[i + k + 1, :]
			return false
		end
	end
	return true
end

function main()
	sol = 0
	lines = readlines("input")
	split_indices = findall(x -> length(x) == 0, lines)
	push!(split_indices, length(lines)+1)
	pushfirst!(split_indices, 0)
	for (start, endd) in IterTools.partition(split_indices, 2, 1)
		mapp = reduce(vcat, permutedims.(collect.(lines[start+1:endd-1])))
		(rows, columns) = size(mapp)
		found = false
		for i in 1:rows-1
			if mapp[i, :] == mapp[i+1, :]
				if is_sym(i, mapp)
					sol += 100 * i
					found = true
					break
				end
			end
		end
		if !found
			for i in 1:columns-1
				if mapp[:, i] == mapp[:, i+1]
					if is_sym(i, mapp, false)
						sol += i
						break
					end
				end
			end
		end
	end
	print("Soluzione: ", sol)
end

main()