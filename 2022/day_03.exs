defmodule Day03 do

	def parse_input(file) do
		File.read!(file)
		|> String.split("\n", trim: true)
		|> Enum.map(&String.to_charlist/1)
	end

#--- Part 1

	def solve_1(input), do:
		input
		|> Enum.map(&process_elf/1)
		|> Enum.sum

	def process_elf(rucksacks), do:
		Enum.chunk_every(rucksacks, div(length(rucksacks), 2))
		|> Enum.map(&MapSet.new/1)
		|> Enum.reduce(&MapSet.intersection/2)
		|> MapSet.to_list()
		|> Enum.take(1)
		|> priority()

	def priority(c) do
		if String.upcase("#{c}") == "#{c}" do
			hd(c) - 38
		else
			hd(c) - 96
		end
	end

#--- Part 2

	def solve_2(input), do:
		Enum.chunk_every(input, 3)
		|> Enum.map(&process_elf_group/1)
		|> Enum.sum

	def process_elf_group(rucksacks), do:
		rucksacks
		|> Enum.map(&MapSet.new/1)
		|> Enum.reduce(&MapSet.intersection/2)
		|> MapSet.to_list()
		|> Enum.take(1)
		|> priority()
		

end

parsed_input = Day03.parse_input("inputs/input_03.txt")

Day03.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day03.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()