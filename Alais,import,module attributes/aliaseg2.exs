Code.require_file("../modules/calcmodule.exs")
alias Elixir.String, as: Str


a = IO.gets("Val1: ") |> Str.trim() |> Str.to_integer()
b = IO.gets("Val1: ") |> Str.trim() |> Str.to_integer()

IO.puts("Addition is: #{Calci.add(a, b)}
Subtraction is: #{Calci.sub(a, b)}
Multiplication is: #{Calci.mul(a, b)}
Division is: #{Calci.divi(a, b)}
Modulus is: #{Calci.mod(a, b)}")
