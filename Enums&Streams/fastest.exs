defmodule Demo do
  def test1 do
    1..100_000_000
    |> Stream.map(&(&1 ** 2))
    |> Stream.filter(&(rem(&1, 2) == 0))
    |> Enum.take(100)
  end

  def test2 do
    1..100_000_000
    |> Enum.map(&(&1 ** 2))
    |> Enum.filter(&(rem(&1, 2) == 0))
    |> Enum.take(100)
  end
end

{time, result} = :timer.tc(Demo, :test1, [])
IO.puts("Time taken by stream: #{time / 1_000_000}")
IO.inspect(result)

{time, result} = :timer.tc(Demo, :test2, [])
IO.puts("Time taken by enum: #{time / 1_000_000}")
IO.inspect(result)
