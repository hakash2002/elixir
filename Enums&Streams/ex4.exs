#count
e = [a: 90, b: 99, c: 75, d: 77, e: 90, f: 90, g: 90, h: 100]

k =
  e |> Enum.count(fn {_,a} -> a == 90 end)

IO.puts(k)

#frequencies
k =
  e |> Stream.map(fn {_,a} -> a end) |> Enum.frequencies()

IO.inspect(k)

#frequencies_by will do same as the above
k =
  e |> Enum.frequencies_by(fn {_,a} -> a end)

IO.inspect(k)
