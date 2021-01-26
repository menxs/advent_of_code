defmodule Day04 do

	def parse_input(file) do
		File.read!(file)
		|> String.trim()
		|> String.split("\n\n")
		|> Enum.map(&parse_passport/1)
	end

	def parse_passport(info) do
		info
		|> String.split([" ", "\n"])
		|> Enum.map(&parse_field/1)
		|> Map.new()
	end

	def parse_field(field) do
			field
			|> String.split(":")
			|> List.to_tuple()
	end

#--- Part 1

	@required_fields MapSet.new(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])

	def solve_1(input), do:
		Enum.count(input, &required_fields?/1)

	def required_fields?(passport) do
		fields = MapSet.new(Map.keys(passport))
		MapSet.subset?(@required_fields, fields)
	end

#--- Part 2

	@valid_ecl ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

	def solve_2(input), do:
		Enum.count(input, &valid?/1)

	def valid?(passport) do
		required_fields?(passport) &&
		Enum.all?(passport, &valid_field?/1)
	end

	def valid_field?({"byr", val}), do:
		String.length(val) == 4 && String.to_integer(val) in 1920..2002

	def valid_field?({"iyr", val}), do:
		String.length(val) == 4 && String.to_integer(val) in 2010..2020

	def valid_field?({"eyr", val}), do:
		String.length(val) == 4 && String.to_integer(val) in 2020..2030

	def valid_field?({"hgt", val}), do:
		valid_hgt_in?(val) || valid_hgt_cm?(val)

	def valid_field?({"hcl", val}), do:
		String.length(val) == 7 && String.match?(val, ~r/#[0-9a-f]{6}/)

	def valid_field?({"ecl", val}), do:
		Enum.member?(@valid_ecl, val)

	def valid_field?({"pid", val}), do:
		String.length(val) == 9 && String.match?(val, ~r/\d{9}/)

	def valid_field?({"cid", _val}), do: true

	def valid_hgt_cm?(val), do:
		String.ends_with?(val, "cm") &&
		String.to_integer(String.trim_trailing(val, "cm")) in 150..193

	def valid_hgt_in?(val) do
		String.ends_with?(val, "in") &&
		String.to_integer(String.trim_trailing(val, "in")) in 59..76
	end

end

parsed_input = Day04.parse_input("inputs/input_04.txt")

Day04.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day04.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()