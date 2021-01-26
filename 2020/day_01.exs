defmodule Day01 do

	def parse_input(file) do
		File.read!(file)
		|> String.split()
		|> Enum.map(&String.to_integer/1)
	end

#--- Part 1

	def solve_1(input), do: solve_1(input, 2020)

	def solve_1([], _sum_objective), do: :invalid_expense_report
	def solve_1([h | t], sum_objective) do
		 case Enum.find(t, :keep_lookin, &(&1 + h == sum_objective)) do
		 	:keep_lookin ->
		 		solve_1(t, sum_objective)
		 	x ->
		 		h * x 
		 end
	end

#--- Part 2

	def solve_2(input), do: solve_2(input, 2020)

	def solve_2([], _sum_objective), do: :invalid_expense_report
	def solve_2([h | t], sum_objective) do
		 case solve_1(t, sum_objective - h) do
		 	:invalid_expense_report ->
		 		solve_2(t, sum_objective)
		 	x ->
		 		h * x 
		 end
	end

end

parsed_input = Day01.parse_input("inputs/input_01.txt")

Day01.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day01.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()