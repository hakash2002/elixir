defmodule Rectangle do
  defstruct l: 0, b: 0
end

defmodule Circle do
  defstruct r: 0
end

defmodule Triangle do
  defstruct b: 0, h: 0
end

defprotocol Area do
  def area(a)
end

defimpl Area, for: Rectangle do
  def area(%Rectangle{l: l, b: b}) do
    l * b
  end
end

defimpl Area, for: Circle do
  def area(%Circle{r: r}) do
    3.14 * r * r
  end
end

defimpl Area, for: Triangle do
  def area(%Triangle{b: b, h: h}) do
    0.5 * b * h
  end
end

a = 10
b = 20

rec = %Rectangle{l: a, b: b}
IO.puts("Area of rectangle is: #{Area.area(rec)}")

squ = %Rectangle{l: a, b: a}
IO.puts("Area of square is: #{Area.area(squ)}")

cir = %Circle{r: a}
IO.puts("Area of circle is: #{Area.area(cir)}")

tri = %Triangle{b: a, h: b}
IO.puts("Area of triangle is: #{Area.area(tri)}")
