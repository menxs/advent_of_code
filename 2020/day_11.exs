defmodule Day11 do

	def parse_input(file) do
		File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map_reduce(0, fn row, i -> {{i, parse_row(row)}, i + 1} end)
    |> elem(0)
    |> Map.new()
	end

  def parse_row(row) do
    row
    |> String.to_charlist()
    |> Enum.map_reduce(0, &parse_symbol/2)
    |> elem(0)
    |> Map.new()
  end

  def parse_symbol(?., i), do: {{i, :floor}   , i + 1}
  def parse_symbol(?L, i), do: {{i, :empty}   , i + 1}
  def parse_symbol(?#, i), do: {{i, :occupied}, i + 1}

#--- Part 1

	def solve_1(input) do
    fix_point(input, step(input, 4, &occupied_neighbors/5), 4, &occupied_neighbors/5)
    |> Enum.reduce(0,
        fn {_, row}, acc ->
          acc + Enum.count(row, fn {_, status} -> status == :occupied end)
        end
      )
  end

  def fix_point(old_map, map, tolerance, visibility) do
    if old_map == map do
      map
    else
      new_map = step(map, tolerance, visibility)
      fix_point(map, new_map, tolerance, visibility)
    end
  end

  #Working with lists as matrix was even worse
  #Should have used a matrix module
  def step(map, tolerance, visibility) do
    size_r = Enum.count(map)
    size_c = Enum.count(map[0])
    Enum.map(map,
      fn {r, row} ->
        updated_row =
          Enum.map(row,
            fn {c, :floor} ->
                {c, :floor}
              {c, :empty} ->
                if apply(visibility, [map, r, c, size_r, size_c]) == 0 do
                  {c, :occupied}
                else
                  {c, :empty}
                end
              {c, :occupied} ->
                if apply(visibility, [map, r, c, size_r, size_c]) >= tolerance do
                  {c, :empty}
                else
                  {c, :occupied}
                end
            end
          )
          {r, Map.new(updated_row)}
      end
    )
    |> Map.new()
  end

  def occupied_neighbors(map, r, c, size_r, size_c) do
    neighbors(r, c, size_r, size_c)
    |> Enum.count(& get_in(map, &1) == :occupied)
  end

  def neighbors(0, 0, _size_r, _size_c), do:
    [[0, 1], [1, 0], [1, 1]]
  def neighbors(0, c, _size_r, _size_c), do:
    [[0, c - 1], [0, c + 1], [1, c - 1], [1, c], [1, c + 1]]
  def neighbors(r, 0, _size_r, _size_c), do:
    [[r - 1, 0], [r - 1, 1], [r, 1], [r + 1, 0], [r + 1, 1]]
  def neighbors(r, c, r, c), do:
    [[r - 1, c - 1], [r - 1, c], [r, c - 1]]
  def neighbors(r, c, r, _size_c), do:
    [[r - 1, c - 1], [r - 1, c], [r - 1, c + 1], [r, c - 1], [r, c + 1]]
  def neighbors(r, c, _size_r, c), do:
    [[r - 1, c - 1], [r - 1, c], [r, c - 1], [r + 1, c - 1], [r + 1, c]]
  def neighbors(r, c, _size_r, _size_c), do:
    [[r - 1, c - 1], [r - 1, c], [r - 1, c + 1], [r, c - 1],
      [r, c + 1], [r + 1, c - 1], [r + 1, c], [r + 1, c + 1]]

#--- Part 2

	def solve_2(input) do
  fix_point(input, step(input, 5, &visible_neighbors/5), 5, &visible_neighbors/5)
    |> Enum.reduce(0,
        fn {_, row}, acc ->
          acc + Enum.count(row, fn {_, status} -> status == :occupied end)
        end
      )
  end

  def visible_neighbors(map, r, c, size_r, size_c) do
    see(map, r - 1, c - 1, size_r, size_c, -1, -1) +
    see(map, r - 1, c    , size_r, size_c, -1,  0) +
    see(map, r - 1, c + 1, size_r, size_c, -1, +1) +
    see(map, r    , c - 1, size_r, size_c,  0, -1) +
    see(map, r    , c + 1, size_r, size_c,  0, +1) +
    see(map, r + 1, c - 1, size_r, size_c, +1, -1) +
    see(map, r + 1, c    , size_r, size_c, +1,  0) +
    see(map, r + 1, c + 1, size_r, size_c, +1, +1)
  end

  def see(_map, -1, _c, _size_r, _size_c, _inc_r, _inc_c), do: 0
  def see(_map, _r, -1, _size_r, _size_c, _inc_r, _inc_c), do: 0
  def see(_map, _r, size_c, _size_r, size_c, _inc_r, _inc_c), do: 0
  def see(_map, size_r, _c, size_r, _size_c, _inc_r, _inc_c), do: 0
  def see(map, r, c, size_r, size_c, inc_r, inc_c) do
    case map[r][c] do
      :occupied -> 1
      :empty -> 0
      :floor ->
        see(map, r + inc_r, c + inc_c, size_r, size_c, inc_r, inc_c)
    end
  end

end

parsed_input = Day11.parse_input("inputs/input_11.txt")

Day11.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day11.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()