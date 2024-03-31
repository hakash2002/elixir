defmodule Calci do
  def add(a, b), do: a + b
  def sub(a, b), do: a - b
  def mul(a, b), do: a * b

  def divi(a, b) do
    if b != 0 do
      a / b
    else
      "Zero divison error"
    end
  end

  def mod(a, b) do
    if is_integer(divi(a, b)) do
      rem(a, b)
    else
      "Zero modulus error"
    end
  end
end

y = String.to_integer(IO.gets("Enter artithmetic operation:
              1: Addition
              2: Subtraction
              3: Multiplication
              4: Division
              5: Modulus
              ") |> String.trim())

{a,b} = if y < 6 and y > 0 do
  a = String.to_integer(IO.gets("Enter first value: ") |> String.trim())
  b = String.to_integer(IO.gets("Enter second value: ") |> String.trim())
  {a,b}
  else
    {"a","a"}
end

ans =
  case y do
    1 ->
      Calci.add(a, b)

    2 ->
      Calci.sub(a, b)

    3 ->
      Calci.mul(a, b)

    4 ->
      Calci.divi(a, b)

    5 ->
      Calci.mod(a, b)

    _ ->
      "Invalid entry"
  end

IO.puts(ans)
