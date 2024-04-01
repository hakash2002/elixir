defmodule Match do
  def returnfirsttwentychars(a),do: String.slice(a,0..19)
end

IO.puts(Match.returnfirsttwentychars("123456789012345678901234"))
{time, result} = :timer.tc(Match, :returnfirsttwentychars, ["1234567890123456789012345678"])
IO.puts("Execution time: #{time} microseconds #{result}")
