defmodule Day03 do

	def parse_input(file) do
		File.read!(file)
		|> String.to_charlist()
	end

#--- Part 1
	
	def solve_1(input), do: solve_1(input, 0, 0, MapSet.new())

	def solve_1([], pos_x, pos_y, visited), do: MapSet.size(MapSet.put(visited, {pos_x, pos_y}))
	def solve_1([?^ | t], pos_x, pos_y, visited), do: solve_1(t, pos_x + 1, pos_y, MapSet.put(visited, {pos_x, pos_y}))
	def solve_1([?v | t], pos_x, pos_y, visited), do: solve_1(t, pos_x - 1, pos_y, MapSet.put(visited, {pos_x, pos_y}))
	def solve_1([?< | t], pos_x, pos_y, visited), do: solve_1(t, pos_x, pos_y - 1, MapSet.put(visited, {pos_x, pos_y}))
	def solve_1([?> | t], pos_x, pos_y, visited), do: solve_1(t, pos_x, pos_y + 1, MapSet.put(visited, {pos_x, pos_y}))

#--- Part 2

	def solve_2(input), do: mov_santa(input, %{santa: {0, 0}, robosanta: {0,0}}, MapSet.new([{0,0}]))

	def mov_santa([], _, visited), do: MapSet.size(visited)
	def mov_santa([h | t], pos, visited) do
		new_pos = update_in(pos, [:santa], &move(h, &1))
		mov_robosanta(t, new_pos, MapSet.put(visited, new_pos.santa))
	end

	def mov_robosanta([], _, visited), do: MapSet.size(visited)
	def mov_robosanta([h | t], pos, visited) do
		new_pos = update_in(pos, [:robosanta], &move(h, &1))
		mov_santa(t, new_pos, MapSet.put(visited, new_pos.robosanta))
	end

	def move(?^, {pos_x, pos_y}), do: {pos_x + 1, pos_y}
	def move(?v, {pos_x, pos_y}), do: {pos_x - 1, pos_y}
	def move(?<, {pos_x, pos_y}), do: {pos_x, pos_y - 1}
	def move(?>, {pos_x, pos_y}), do: {pos_x, pos_y + 1}

end

parsed_input = Day03.parse_input("inputs/input_03.txt")

Day03.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day03.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()