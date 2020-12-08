defmodule Day04 do

	def parse_input(file) do
		File.read!(file)
	end

#--- Part 1

	def solve_1(input), do: solve_1(input, 0)

	def solve_1(input, n) do
		hash =
			:crypto.hash(:md5, "#{input}#{n}")
			|> Base.encode16()
		if String.starts_with?(hash, "00000") do
			n
		else
			solve_1(input, n + 1)
		end
	end
	
#--- Part 2

	def solve_2(input), do: solve_2(input, 0)

	def solve_2(input, n) do
		hash =
			:crypto.hash(:md5, "#{input}#{n}")
			|> Base.encode16()
		if String.starts_with?(hash, "000000") do
			n
		else
			solve_2(input, n + 1)
		end
	end

end

parsed_input = Day04.parse_input("inputs/input_04.txt")

Day04.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day04.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()