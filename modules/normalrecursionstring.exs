defmodule Tailendrecur do
  def firsttwenty(n, a) when n > 0 do
    s = String.at(a,20-n) <> firsttwenty(n - 1, a)
    s
    end
    def firsttwenty(0, _a) do
      "
      done"
    end
  end


IO.puts(Tailendrecur.firsttwenty(20,"123456789012345678901234567"))
{time, _result} = :timer.tc(Tailendrecur, :firsttwenty, [20,"1234567890123456789012345678"])
IO.puts("Execution time: #{time} microseconds #{result}")
