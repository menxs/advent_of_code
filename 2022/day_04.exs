defmodule Day04 do

	def parse_input(file) do
		File.read!(file)
		|> String.split("\n", trim: true)
		|> Enum.map(&parse_line/1)
	end

	def parse_line(line), do:
		String.split(line, [",", "-"])
		|> Enum.map(&String.to_integer/1)



#--- Part 1

	def solve_1(input), do:
		input
		|> Enum.filter(&redundant_pair/1)
		|> Enum.count()

	def redundant_pair([min1, max1, min2, max2]) when min1 >= min2 and max1 <= max2, do: true
	def redundant_pair([min1, max1, min2, max2]) when min1 <= min2 and max1 >= max2, do: true
	def redundant_pair(_), do: false


#--- Part 2

	def solve_2(input), do:
		input
		|> Enum.filter(&overlap_pair/1)
		|> Enum.count()

	def overlap_pair([min1, _, min2, max2]) when min2 <= min1 and min1 <= max2, do: true
	def overlap_pair([_, max1, min2, max2]) when min2 <= max1 and max1 <= max2, do: true
	def overlap_pair([min1, max1, min2, max2]) when min1 <= min2 and max1 >= max2, do: true
	def overlap_pair(_), do: false
		

end

parsed_input = Day04.parse_input("inputs/input_04.txt")

Day04.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day04.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()