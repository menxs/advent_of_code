defmodule Day01 do

	def parse_input(file) do
		File.read!(file)
		|> String.split("\n\n")
		|> Enum.map(&String.split/1)
		|> Enum.map(fn elf -> Enum.map(elf, &String.to_integer/1) end)
	end

#--- Part 1

	def solve_1(input), do: 
		input
		|> Enum.map(&Enum.sum/1)
		|> Enum.max

#--- Part 2

	def solve_2(input), do:
		input
		|> Enum.map(&Enum.sum/1)
		|> Enum.sort(:desc)
		|> Enum.take(3)
		|> Enum.sum
		

end

parsed_input = Day01.parse_input("inputs/input_01.txt")

Day01.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day01.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()