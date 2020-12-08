defmodule Day00 do

	def parse_input(file) do
		File.read!(file)
	end

#--- Part 1

	def solve_1(input), do: :ok

#--- Part 2

	def solve_2(input), do: :ok

end

alias Day00

parsed_input = parse_input("inputs_input_00.txt")

solve_1(parsed_input) |> &IO.puts("Part 1: #{&1}")

solve_2(parsed_input) |> &IO.puts("Part 2: #{&1}")