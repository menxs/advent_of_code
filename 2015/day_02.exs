defmodule Day02 do

	def parse_input(file) do
		File.read!(file)
		|> String.trim()
		|> String.split()
		|> Enum.map(&String.split(&1, "x"))
		|> Enum.map(&Enum.map(&1, fn s -> String.to_integer(s) end))
	end

#--- Part 1

	def solve_1(input), do:
		Enum.reduce(input, 0, fn dim, acc -> wraping_needed(dim) + acc end)

	def wraping_needed([l, w, h]), do:
		2*l*w + 2*w*h + 2*h*l + Enum.min([l*w, w*h, h*l])

#--- Part 2

	def solve_2(input), do:
		Enum.reduce(input, 0, fn dim, acc -> ribbon_needed(dim) + acc end)

	def ribbon_needed([l, w, h] = dim), do:
		2*l + 2*w + 2*h - 2*Enum.max(dim) + l*w*h

end

parsed_input = Day02.parse_input("inputs/input_02.txt")

Day02.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day02.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()