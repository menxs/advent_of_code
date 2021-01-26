defmodule Day03 do

	def parse_input(file) do
		File.read!(file)
		|> String.split()
	end

#--- Part 1

	def solve_1(input), do:
		Enum.reduce(input, {0, 0}, &slide/2)
		|> elem(1)

	def slide(row, {lateral_pos, count}) do
		if String.at(row, Integer.mod(lateral_pos, String.length(row))) == "#" do
			{lateral_pos + 3, count + 1}
		else
			{lateral_pos + 3, count}
		end
	end

#--- Part 2

	def solve_2(input), do:
		slide(input, 1, 1) *
		slide(input, 1, 3) *
		slide(input, 1, 5) *
		slide(input, 1, 7) *
		slide(input, 2, 1)

	def slide(map, inc_x, inc_y), do: slide(map, 0, 0, inc_x, inc_y, 0)

	def slide(map, pos_x, _pos_y, _inc_x, _inc_y, trees_hit)
				when pos_x >= length(map), do: trees_hit

	def slide(map, pos_x, pos_y, inc_x, inc_y, trees_hit) do
		row = Enum.at(map, pos_x)
		location = String.at(row, Integer.mod(pos_y, String.length(row)))
		if location == "#" do
			slide(map, pos_x + inc_x, pos_y + inc_y, inc_x, inc_y, trees_hit + 1)
		else
			slide(map, pos_x + inc_x, pos_y + inc_y, inc_x, inc_y, trees_hit)
		end
	end

end

parsed_input = Day03.parse_input("inputs/input_03.txt")

Day03.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day03.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()