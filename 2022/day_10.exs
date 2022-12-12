defmodule Day10 do

	def parse_input(file) do
		File.read!(file)
		|> String.split("\n", trim: true)
		|> Enum.map(&parse_line/1)
		|> List.flatten()
		|> Enum.reduce([1], fn x, acc -> [x + hd(acc) | acc] end)
		|> Enum.reverse()
	end

	def parse_line("noop"), do: [0]
	def parse_line("addx " <> n), do:[0, String.to_integer(n)]

#--- Part 1

	def solve_1(input) do
		input
		|> Enum.with_index(1)
		|> Enum.drop(19)
		|> Enum.take_every(40)
		|> Enum.map(fn {signal, cycle} -> signal * cycle end)
		|> Enum.sum()
	end

#--- Part 2

	def solve_2(input) do
		|> Enum.chunk_every(40)
		|> Enum.map(&Enum.with_index/1)
		|> Enum.map(&crt_row/1)
		|> Enum.join("\n")
	end

	def crt_row(row) do
    Enum.map(row, fn
        {pos, pixel} when abs(pos-pixel) <= 1 -> "#"
        _ -> "."
    end)
   |> Enum.join()
  end

end

parsed_input = Day10.parse_input("inputs/input_10.txt")

Day10.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day10.solve_2(parsed_input) |> (&IO.puts("Part 2: \n#{&1}")).()
