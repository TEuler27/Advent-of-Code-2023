function lines_needed(nums)
	if length(Set(nums)) == 1
		return 1
	end
	for n in 2:(length(nums)-1)
		checks = length(nums) - n
		skipped = false
		for k in 1:checks
			total = nums[k]
			coeff = 1
			for i in 1:n-1
				coeff *= ((n-i) / i)
				total += ((-1)^i * coeff * nums[i+k]) 
			end
			if abs(total) < 10e-5
				global num_lines = n
			else
				skipped = true
				break
			end
		end
		if !skipped && num_lines == n
			break
		end
	end
	return num_lines
end

function predict(nums, num_lines)
	if num_lines == 1
		return nums[1]
	end
	
	sol = -nums[length(nums) - num_lines + 2]
	coeff = 1
	for i in 1:num_lines-2
		coeff *= ((num_lines - i) / i)
		sol += ((-1)^(i+1) * coeff * nums[length(nums) - num_lines + 2 + i]) 
	end
	if num_lines % 2 == 0
		sol = -sol
	end 
	return round(Int64,sol)
end


lines = readlines("input")
global sol = 0
for line in lines
	nums = parse.(Int64, split(line, ' '))
	num_lines = lines_needed(nums)
	global sol += predict(nums, num_lines)
end
print(sol)