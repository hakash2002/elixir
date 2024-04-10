#map
k =
  1..100
  |> Stream.map(fn a ->
    if rem(a, 2) == 0 do
      "Even"
    else
      "Odd"
    end
  end)
  |> Enum.to_list()

IO.inspect(k)

#map_every
k =
  1..100
  |> Stream.map_every(2, fn _ -> "Odd" end)

IO.inspect(k)
