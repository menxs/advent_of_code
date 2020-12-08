defmodule Day05 do

	def parse_input(file) do
		File.read!(file)
		|> String.split()
		|> Enum.map(&parse_seat_code/1)
	end

	def parse_seat_code(seat_code) do
		String.split_at(seat_code, 7)
	end

#--- Part 1

	def solve_1(input), do: Enum.max(Enum.map(input, &seat_id/1))

	def seat_id({row_code, col_code}), do:
		row_n(row_code) * 8 + col_n(col_code)

	def row_n(row_code), do: row_n(String.to_charlist(row_code), 0)
	def row_n([], acc), do: acc
	def row_n([?F | t], acc), do: row_n(t, acc)
	def row_n([?B | t], acc), do: row_n(t, acc + :math.pow(2, length(t)))

	def col_n(col_code), do: col_n(String.to_charlist(col_code), 0)
	def col_n([], acc), do: acc
	def col_n([?L | t], acc), do: col_n(t, acc)
	def col_n([?R | t], acc), do: col_n(t, acc + :math.pow(2, length(t)))

#--- Part 2

	def solve_2(input), do: find_seat(Enum.sort(Enum.map(input, &seat_id/1)))

	def find_seat([seat_1 | [seat_2 | _]]) when seat_1 + 2 == seat_2, do: seat_1 + 1
	def find_seat([_ | t]), do: find_seat(t)
	def find_seat([]), do: :not_found

end

parsed_input = Day05.parse_input("inputs/input_05.txt")

Day05.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day05.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()