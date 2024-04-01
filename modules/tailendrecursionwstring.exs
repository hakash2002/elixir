defmodule Tailendrecur do
  def firsttwenty(n, a, acc) when n > 0 do
    s = acc <> String.at(a, 20 - n)
    firsttwenty(n - 1, a, s)
  end

  def firsttwenty(0, _a, acc), do: acc
end

IO.puts(Tailendrecur.firsttwenty(20, "1234567890123456789012345678", ""))
{time, _result} = :timer.tc(Tailendrecur, :firsttwenty, [20,"1234567890123456789012345678",""])
IO.puts("Execution time: #{time} microseconds #{result}")
