defmodule Day06 do

	def parse_input(file) do
		File.read!(file)
		|> String.trim()
		|> String.split("\n\n")
		|> Enum.map(&String.split/1)
	end

#--- Part 1

	def solve_1(input), do:
		Enum.sum(Enum.map(input, &group_anyone_count/1))

	def group_anyone_count(group_answers), do:
		group_anyone_count(group_answers, MapSet.new())

	def group_anyone_count([], set), do: MapSet.size(set)
	def group_anyone_count([h | t], set) do
		new_set =
			h
			|> String.to_charlist()
			|> MapSet.new()
			|> MapSet.union(set)
		group_anyone_count(t, new_set)
	end

#--- Part 2

	@questions String.to_charlist("abcdefghijklmnopqrstuvwxyz")

	def solve_2(input), do:
		Enum.sum(Enum.map(input, &group_everyone_count/1))

	def group_everyone_count(group_answers), do:
		group_everyone_count(group_answers, MapSet.new(@questions))

	def group_everyone_count([], set), do: MapSet.size(set)
	def group_everyone_count([h | t], set) do
		new_set =
			h
			|> String.to_charlist()
			|> MapSet.new()
			|> MapSet.intersection(set)
		group_everyone_count(t, new_set)
	end

end

parsed_input = Day06.parse_input("inputs/input_06.txt")

Day06.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day06.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()