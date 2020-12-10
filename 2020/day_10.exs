defmodule Day10 do

	def parse_input(file) do
		File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
	end

#--- Part 1

	def solve_1(input) do
    {diff_1, _diff_2, diff_3} = use_all(input)
    diff_1 * diff_3
  end

  def use_all(adapters), do:
    use_all(Enum.sort(adapters, :asc), 0, 0, 0, 0)

  def use_all([h | t], jolts, diff_1, diff_2, diff_3) do
    case h - jolts do
      1 ->
        use_all(t, h, diff_1 + 1, diff_2, diff_3)
      2 ->
        use_all(t, h, diff_1, diff_2 + 1, diff_3)
      3 ->
        use_all(t, h, diff_1, diff_2, diff_3 + 1)
    end
  end
  def use_all([], _, diff_1, diff_2, diff_3), do:
    {diff_1, diff_2, diff_3 + 1}

#--- Part 2

	def solve_2(input) do 
    sorted_adapters =
      [0 | input]
      |> Enum.sort(:desc)
      |> Enum.map(& %{jolts: &1, paths: 0})

    device = %{jolts: Enum.at(sorted_adapters, 0).jolts + 3, paths: 1}
    count_paths([device | sorted_adapters], 3)
  end

  def count_paths([adapter | []], _permited_diff), do: adapter.paths
  def count_paths([adapter | t], permited_diff) do

    {posible_adapters, other_adapters} =
      Enum.split(t, permited_diff)

    {connectable_adapters, unconnectable_adapters} =
      Enum.split_with(posible_adapters, &connectable?(adapter, &1))

    updated_adapters =
      Enum.map(connectable_adapters, &add_paths(&1, adapter.paths))

    count_paths(
      Enum.concat(
        [
          updated_adapters,
          unconnectable_adapters,
          other_adapters
        ]
      ),
      permited_diff
    )
  end

  def add_paths(adapter, x), do: %{adapter | paths: adapter.paths + x}
  def connectable?(a1, a2) when a1 > a2, do: a1.jolts - 3 <= a2.jolts
end

parsed_input = Day10.parse_input("inputs/input_10.txt")

Day10.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day10.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()