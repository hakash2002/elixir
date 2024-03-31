add = &(&1 + &2)
sub = &-/2
mul = &*/2

div = fn
  a, b
  when b != 0 ->
    a / b

  _a, _b ->
    "Zero divison error"
end

mod = fn a, b ->
  if is_float(div.(a, b)) do
    rem(a, b)
  else
    div.(a, b)
  end
end

a = 10
b = 0
x = "/"

y =
  cond do
    x == "+" ->
      add.(a, b)

    x == "-" ->
      sub.(a, b)

    x == "*" ->
      mul.(a, b)

    x == "/" ->
      div.(a, b)

    x == "%" ->
      mod.(a, b)
  end

IO.puts(y)
