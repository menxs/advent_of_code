defmodule Day02 do

	def parse_input(file) do
		File.read!(file)
		|> String.split()
		|> parse_input([]) 
	end

	def parse_input([], acc), do: acc
	def parse_input([range | [letter | [password | t]]], acc) do

		[min, max] =
			range
			|> String.split("-")
			|> Enum.map(&String.to_integer/1)

		letter = 
			letter
			|> String.to_charlist()
			|> List.first()

		parsed_value = %{
			min: min,
			max: max,
			letter: letter,
			password: password
		}

		parse_input(t, [parsed_value | acc])
	end

#--- Part 1

	def solve_1(input), do:
		Enum.count(input, &valid_1?/1)

	def valid_1?(p) do
		n = Enum.count(String.to_charlist(p.password), &(&1 == p.letter))
		p.min <= n and n <= p.max
	end

#--- Part 2

	def solve_2(input), do:
		Enum.count(input, &valid_2?/1)

	def valid_2?(p) do
		password = String.to_charlist(p.password)
		pos1 = Enum.at(password, p.min - 1)
		pos2 = Enum.at(password, p.max - 1)
		xor(pos1 == p.letter, p.letter == pos2)
	end

	def xor(true, false), do: true
	def xor(false, true), do: true
	def xor(_, _), do: false

end

parsed_input = Day02.parse_input("inputs/input_02.txt")

Day02.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day02.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()