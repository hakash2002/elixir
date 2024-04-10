defmodule Prime do
  defp primenum?(n) do
    k = n - 1
    2..k |> Enum.all?(fn a -> rem(n, a) != 0 end)
  end

  def firstnprime(n) do
    2..n |> Stream.filter(fn a -> primenum?(a) end) |> Enum.to_list()
  end

  def firstncomposite(n) do
    2..n |> Stream.reject(fn a -> primenum?(a) end) |> Enum.to_list()
  end
end

# Prints the primenumbers between 1 and the input
k = IO.gets("Enter number: ")
k
|> String.trim()
|> String.to_integer()
|> Prime.firstnprime()
|> IO.inspect()

# Prints the composite numbers between 1 and the input
k
|> String.trim()
|> String.to_integer()
|> Prime.firstncomposite()
|> IO.inspect()
