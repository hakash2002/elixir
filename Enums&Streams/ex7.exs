#Sum of even nums
1..1000000
|> Stream.filter(&rem(&1,2) == 0)
|> Enum.sum()
|> IO.puts()

#Sum of odd nums
1..1000000
|> Stream.filter(&rem(&1,2) != 0)
|> Enum.sum()
|> IO.puts()
