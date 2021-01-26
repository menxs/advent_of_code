defmodule Day05 do

	def parse_input(file) do
		File.read!(file)
		|> String.split()
	end

#--- Part 1

	@vowels [?a,?e, ?i, ?o, ?u]

	@disallowed_str ["ab", "cd", "pq", "xy"]

	def solve_1(input), do: Enum.count(input, &nice?/1)

	def nice?(str), do: rule1(str) && rule2(str) && rule3(str)

	#three vowels
	def rule1(str), do:
		str
		|> String.to_charlist()
		|> Enum.count(& &1 in @vowels)
		|> (& &1 >= 3).()

	#double letter
	def rule2(str) when is_binary(str), do: rule2(String.to_charlist(str))
	def rule2([same | [same | _]]), do: true
	def rule2([_ | t]), do: rule2(t)
	def rule2([]), do: false

	#not disallowed substrings
	def rule3(str), do:
		! Enum.any?(@disallowed_str, &String.contains?(str, &1))

#--- Part 2

	def solve_2(input), do: Enum.count(input, &new_nice?/1)

	def new_nice?(str), do: rule4(str) && rule5(str)

	#double pair
	def rule4(str) when byte_size(str) > 3 do
		{pair, rest} = String.split_at(str, 2)
		if String.contains?(rest, pair) do
			true
		else
			rule4(String.slice(str, 1..-1))
		end
	end
	def rule4(_), do: false

	#double letter spaced
	def rule5(str) when is_binary(str), do: rule5(String.to_charlist(str))
	def rule5([same | [_ | [same | _]]]), do: true
	def rule5([_ | t]), do: rule5(t)
	def rule5([]), do: false


end

parsed_input = Day05.parse_input("inputs/input_05.txt")

Day05.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day05.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()