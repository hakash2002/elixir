#reducewhile
k = Enum.reduce_while(1..100, 0, fn a, acc ->
    if rem(a, 2) == 0 do
      {:cont, a + acc}
    else
      {:cont, acc}
    end
  end)

IO.inspect(k)

#reduce
k =
  Enum.reduce(1..10000, 0, fn a, acc ->
    a + acc end)

IO.puts(k)
