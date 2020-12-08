defmodule Day07 do

	def parse_input(file) do
		File.read!(file)
		|> String.trim()
		|> String.split(".\n")
		|> Enum.map(&parse_rule/1)
		|> Map.new()
	end

	def parse_rule(rule) do
		[bag, insides] = String.split(rule, " bags contain ")
		if String.starts_with?(insides, "no") do
			{bag, []}
		else
			bags_inside =
				insides
				|> String.split(", ")
				|> Enum.map(&parse_inside_bags/1)
			{bag, bags_inside}
		end
	end

	def parse_inside_bags(bag) do
		[n | words] = String.split(bag, " ")
		number = String.to_integer(n)
		color =
			words
			|> List.delete_at(-1)
			|> Enum.join(" ")
		{number, color}
	end

#--- Part 1

	def solve_1(input) do
		possible_bags = List.delete(Map.keys(input), "shiny gold")
		Enum.count(possible_bags, &(contains?(&1, input, "shiny gold") == true))
	end

	def contains?(bag, rules, objective_bag), do: contains?(bag, rules, objective_bag, [])

	def contains?(same_bag, _rules, same_bag, _researched_bags), do: true
	def contains?(bag, rules, objective_bag, researched_bags) do
		if bag not in researched_bags do
			insides = Enum.map(rules[bag], fn {_n, color} -> color end)
			Enum.any?(insides, &contains?(&1, rules, objective_bag, [bag | researched_bags]))
		else
			false
		end
	end

#--- Part 2

	def solve_2(input), do: bags_required("shiny gold", input)

	def bags_required(bag, rules) do
		Enum.reduce(rules[bag], 0,
								fn {n, color}, acc ->
									acc + n + n * bags_required(color, rules)
								end)
	end

end

parsed_input = Day07.parse_input("inputs/input_07.txt")

Day07.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day07.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()