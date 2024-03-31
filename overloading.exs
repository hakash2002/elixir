defmodule Overloading do
  def add(a,b), do: a + b
  def add(a,b,c), do: a + b + c
end

IO.puts(Overloading.add(1,2,3))
IO.puts(Overloading.add(1,2))
