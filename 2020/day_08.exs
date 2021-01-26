defmodule Day08 do

	def parse_input(file) do
		File.read!(file)
		|> String.split("\n", trim: true)
		|> Enum.map(&parse_instruction/1)
	end

	def parse_instruction(instruction) do
		[name, val_str] = String.split(instruction, " ")
		{name, String.to_integer(val_str)}
	end

#--- Part 1

	def solve_1(input) do
		{:infinite_loop, acc, _} = run(input)
		acc
	end
	
	def run(instructions), do: run(instructions, 0, 0, [])

	def run(instructions, pointer, acc, _visited)
				when pointer >= length(instructions), do: acc

	def run(instructions, pointer, acc, visited) do
		if pointer not in visited do
			instruction = Enum.at(instructions, pointer)
			{updated_pointer, updated_acc} = execute(instruction, pointer, acc)
			run(instructions, updated_pointer, updated_acc, [pointer | visited])
		else
			{:infinite_loop, acc, visited}
		end
	end

	def execute({"nop", _}, pointer, acc), do: {pointer + 1, acc}
	def execute({"acc", x}, pointer, acc), do: {pointer + 1, acc + x}
	def execute({"jmp", x}, pointer, acc), do: {pointer + x, acc}

#--- Part 2

	def solve_2(input) do
		{:infinite_loop, acc, visited} = run(input)
		fix_run(input, acc, visited)
	end

	#Search backwards and change jmp to nop and nop to jmp
	def fix_run(instructions, acc, [ p | visited]) do
		{name, val} = Enum.at(instructions, p)
		case name do
			"acc" ->
				fix_run(instructions, acc - val, visited)
			"nop" ->
				{updated_pointer, _} = execute({"jmp", val}, p, acc)
				case run(instructions, updated_pointer, acc, [p | visited]) do
					#Keep searching backwards
					{:infinite_loop, _, _} -> fix_run(instructions, acc, visited)
					acc -> acc
				end
			"jmp" ->
				{updated_pointer, _} = execute({"nop", val}, p, acc)
				case run(instructions, updated_pointer, acc, [p | visited]) do
					#Keep searching backwards
					{:infinite_loop, _, _} -> fix_run(instructions, acc, visited)
					acc -> acc
				end
		end
	end

end

parsed_input = Day08.parse_input("inputs/input_08.txt")

Day08.solve_1(parsed_input) |> (&IO.puts("Part 1: #{&1}")).()

Day08.solve_2(parsed_input) |> (&IO.puts("Part 2: #{&1}")).()