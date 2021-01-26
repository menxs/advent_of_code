defmodule Day09 do

	def parse_input(file) do
		File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
	end

#--- Part 1

	def solve_1(input) do
    {preamble, list} = Enum.split(input, 25)
    {:error, n} = check(Enum.reverse(preamble), list)
    n
  end

  def check(_preamble, []), do: :ok
  def check(preamble, [h | t]) do
    if valid?(preamble, h) do
      check([h | Enum.drop(preamble, -1)], t)
    else
      {:error, h}
    end
  end

  def valid?([], _), do: false
  def valid?([h | t], n) do
     case Enum.find(t, :keep_lookin, &(&1 != h && &1 + h == n)) do
      :keep_lookin ->
        valid?(t, n)
      _ ->
        true
     end
  end

#--- Part 2

	def solve_2(input, s1) do
    {contiguous_set, list} = Enum.split(input, 2)
    solve_2(Enum.reverse(contiguous_set), list,
            Enum.sum(contiguous_set), s1)
  end

  def solve_2(contiguous_set, [h | t] = l, sum, s1) do
    case sum do
      x when x < s1 ->
        solve_2([h | contiguous_set], t, sum + h, s1)
      x when x == s1 ->
        Enum.min(contiguous_set) + Enum.max(contiguous_set)
      x when x > s1 ->
        if length(contiguous_set) == 2 do
          solve_2([h | contiguous_set], t, sum + h, s1)
        else
          solve_2(Enum.drop(contiguous_set, -1), l,
                  sum - Enum.at(contiguous_set, -1), s1)
        end
    end
  end

end

parsed_input = Day09.parse_input("inputs/input_09.txt")

s1 = Day09.solve_1(parsed_input)

s1 |> (&IO.puts("Part 1: #{&1}")).()

Day09.solve_2(parsed_input, s1) |> (&IO.puts("Part 2: #{&1}")).()