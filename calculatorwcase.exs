x = "/"
k = 10
l = 0

y =
  case x do
    "+" ->
      k + l

    "-" ->
      k - l

    "/" ->
      if l != 0 do
        k / l
      else
        "Zero division error"
      end

    "*" ->
      k * l

    "%" ->
      unless l == 0 do
        rem(k,l)
      else
        "Arithmetic Error"
      end

    _ ->
      "Invalid operator"
  end

IO.puts(y)
