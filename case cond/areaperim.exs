x = "Area"
shape = "rectangle"

a = 20
b = 20
c = 10
s = (a + b + c) / 2

reca = &*/2
recp = &(2 * (&1 + &2))

tria = fn a, b, c ->
  trunc((s * (s - a) * (s - b) * (s - c)) ** 0.5)
end

trip = &(&1 + &2 + &3)

circa = &(3.14 * &1 ** 2)
circp = &(2 * 3.14 * &1)

y =
  case x do
    "Area" ->
      cond do
        shape == "rectangle" ->
          reca.(a, b)

        shape == "square" ->
          reca.(a, a)

        shape == "triangle" ->
          tria.(a, b, c)

        shape == "circle" ->
          circa.(a)
      end

    "Perimeter" ->
      cond do
        shape == "rectangle" ->
          recp.(a, b)

        shape == "square" ->
          recp.(a, a)

        shape == "triangle" ->
          trip.(a, b, c)

        shape == "circle" ->
          circp.(a)
      end
  end

IO.puts("#{x} of #{shape} is #{y}")
