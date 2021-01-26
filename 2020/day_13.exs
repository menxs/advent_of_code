defmodule Day00 do

	def parse_input(file) do
    [str_val, buses_ids] =
  		File.read!(file)
      |> String.split("\n", trim: true)
    {String.to_integer(str_val), Enum.map(String.split(buses_ids, ","), &parse_bus/1)}
	end

  def parse_bus("x"), do: :not_available
  def parse_bus(bus), do: String.to_integer(bus)

#--- Part 1

	def solve_1({arrival_time, buses}) do
    {bus, wait_time} =
      Enum.filter(buses, & &1 != :not_available)
      |> Enum.map(&wait_time(arrival_time, &1))
      |> Enum.min(fn {_, t1}, {_, t2} -> t1 <= t2 end)

    bus * wait_time
  end

  def wait_time(arrival_time, bus) do
    case Integer.mod(arrival_time, bus) do
      x when x == 0 -> {bus, 0}
      x -> {bus, bus - x}
    end
  end

#--- Part 2

	def solve_2({_, buses}) do
    buses_delay =
      buses
      |> Enum.map_reduce(0,
          fn :not_available, acc -> {:not_available, acc + 1}
            bus, acc -> {{bus, acc}, acc + 1}
          end)
      |> elem(0)
      |> Enum.filter(& &1 != :not_available)
      |> Enum.sort(fn {bus1, _}, {bus2, _} -> bus1 >= bus2 end)

    {max_freq, offset} = buses_delay |> List.first()

    buses_offset_to_max = Enum.map(buses_delay, fn {bus, delay} -> {bus, delay - offset} end)

    100000000000000 + max_freq - Integer.mod(100000000000000, max_freq)
    |> find(buses_offset_to_max)
    |> (& &1 - offset).()
  end

  def find(n, [{max_freq, 0}| buses]), do: find(n, max_freq, buses)
#lcm
  def find(n, step, [{bus, offset}| t] = buses) do
    if Integer.mod(n + offset, bus) == 0 do
      find(n, step * bus, t)
    else
      find(n + step, step, buses)
    end
  end

  def find(n, _, []), do: n

  def valid?(n, buses) do
    Enum.all?(buses, fn {bus, offset} -> Integer.mod(n + offset, bus) == 0 end)
  end

end

parsed_input = Day00.parse_input("inputs/input_13.txt")

Day00.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day00.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()