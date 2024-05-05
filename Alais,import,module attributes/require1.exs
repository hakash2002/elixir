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

defmodule Oper do
  require Calci

  def opers() do
    IO.puts(Calci.add(1, 2))
    IO.puts(Calci.mul(1, 2))
    IO.puts(Calci.divi(1, 2))
    IO.puts(Calci.mod(1, 2))
  end
end

Oper.opers()
