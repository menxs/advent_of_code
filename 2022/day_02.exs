defmodule Day02 do

	def parse_input(file) do
		File.read!(file)
		|> String.split("\n", trim: true)
		|> Enum.map(&parse_match/1)
	end

	def parse_match(match), do: String.split(match, " ")

#--- Part 1

	def solve_1(input), do: 
		input
		|> Enum.map(&calculate_points/1)
		|> Enum.sum

	def calculate_points(["A", "X"]), do: 4
	def calculate_points(["A", "Y"]), do: 8
	def calculate_points(["A", "Z"]), do: 3
	def calculate_points(["B", "X"]), do: 1
	def calculate_points(["B", "Y"]), do: 5
	def calculate_points(["B", "Z"]), do: 9
	def calculate_points(["C", "X"]), do: 7
	def calculate_points(["C", "Y"]), do: 2
	def calculate_points(["C", "Z"]), do: 6

#--- Part 2

	def solve_2(input), do:
		input
		|> Enum.map(&calculate_points2/1)
		|> Enum.sum

	def calculate_points2(["A", "X"]), do: 3
	def calculate_points2(["A", "Y"]), do: 4
	def calculate_points2(["A", "Z"]), do: 8
	def calculate_points2(["B", "X"]), do: 1
	def calculate_points2(["B", "Y"]), do: 5 
	def calculate_points2(["B", "Z"]), do: 9
	def calculate_points2(["C", "X"]), do: 2
	def calculate_points2(["C", "Y"]), do: 6
	def calculate_points2(["C", "Z"]), do: 7
		

end

parsed_input = Day02.parse_input("inputs/input_02.txt")

Day02.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day02.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()