defmodule Day01 do

	def parse_input(file) do
		File.read!(file)
		|> String.to_charlist()
	end

#--- Part 1

	def solve_1(input), do: solve_1(input, 0)

	def solve_1([], floor), do:  floor
	def solve_1([?( | t], floor), do: solve_1(t, floor + 1)
	def solve_1([?) | t], floor), do: solve_1(t, floor - 1)

#--- Part 2

	def solve_2(input), do: solve_2(input, 0, 0)

	def solve_2(_input, -1, pos), do:  pos
	def solve_2([?( | t], floor, pos), do: solve_2(t, floor + 1, pos + 1)
	def solve_2([?) | t], floor, pos), do: solve_2(t, floor - 1, pos + 1)
	def solve_2([], _floor, _pos), do:  :error

end

parsed_input = Day01.parse_input("inputs/input_01.txt")

Day01.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day01.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()