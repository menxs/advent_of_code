defmodule Day12 do

	def parse_input(file) do
		File.read!(file)
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_action/1)
	end

  def parse_action(action) do
    {type, str_val} = String.split_at(action, 1)
    {type, String.to_integer(str_val)}
  end

#--- Part 1

	def solve_1(input) do
    {_, n_s, e_w} = Enum.reduce(input, {"E", 0, 0}, &navigate/2)
    abs(n_s) + abs(e_w)
  end

  def navigate({"N", val}, {facing, n_s, e_w}), do: {facing, n_s + val, e_w}
  def navigate({"S", val}, {facing, n_s, e_w}), do: {facing, n_s - val, e_w}
  def navigate({"E", val}, {facing, n_s, e_w}), do: {facing, n_s, e_w + val}
  def navigate({"W", val}, {facing, n_s, e_w}), do: {facing, n_s, e_w - val}
  def navigate({"F", val}, {facing, n_s, e_w}), do: navigate({facing, val}, {facing, n_s, e_w})
  def navigate({"R", val}, {facing, n_s, e_w}), do: {r(facing, val), n_s, e_w}
  def navigate({"L", val}, {facing, n_s, e_w}), do: {l(facing, val), n_s, e_w}

  def r(facing, 0), do: facing
  def r("N", val), do: r("E", val - 90)
  def r("E", val), do: r("S", val - 90)
  def r("S", val), do: r("W", val - 90)
  def r("W", val), do: r("N", val - 90)

  def l(facing, 0), do: facing
  def l("N", val), do: l("W", val - 90)
  def l("W", val), do: l("S", val - 90)
  def l("S", val), do: l("E", val - 90)
  def l("E", val), do: l("N", val - 90)
#--- Part 2

	def solve_2(input) do
    {{n_s, e_w}, _} = Enum.reduce(input, {{0, 0},{1, 10}}, &navigate_waypoint/2)
    abs(n_s) + abs(e_w)
  end

  def navigate_waypoint({"N", val}, {ship, {n_s, e_w}}), do: {ship, {n_s + val, e_w}}
  def navigate_waypoint({"S", val}, {ship, {n_s, e_w}}), do: {ship, {n_s - val, e_w}}
  def navigate_waypoint({"E", val}, {ship, {n_s, e_w}}), do: {ship, {n_s, e_w + val}}
  def navigate_waypoint({"W", val}, {ship, {n_s, e_w}}), do: {ship, {n_s, e_w - val}}

  def navigate_waypoint({"F", val}, {{ship_n_s, ship_e_w}, {n_s, e_w} = waypoint}), do:
    {{ship_n_s + val * n_s, ship_e_w + val * e_w}, waypoint}

  def navigate_waypoint({"R", val}, {ship, waypoint}), do:
    {ship, r_waypoint(waypoint, val)}
  def navigate_waypoint({"L", val}, {ship, waypoint}), do:
    {ship, l_waypoint(waypoint, val)}

  def r_waypoint({n_s, e_w},  90), do: {-e_w, n_s}
  def r_waypoint({n_s, e_w}, 180), do: {-n_s, -e_w}
  def r_waypoint({n_s, e_w}, 270), do: {e_w, -n_s}

  def l_waypoint({n_s, e_w},  90), do: {e_w, -n_s}
  def l_waypoint({n_s, e_w}, 180), do: {-n_s, -e_w}
  def l_waypoint({n_s, e_w}, 270), do: {-e_w, n_s}

end

parsed_input = Day12.parse_input("inputs/input_12.txt")

Day12.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day12.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()