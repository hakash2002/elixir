x = case {1,2,3} do
  {1,x,3} ->
      "x is local so wont show as 2"
  {1,2,_} ->
      "..."
end
IO.puts(x)
