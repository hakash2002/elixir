# sort
enum = [:a, :b, :z, :f, :k, :l, :o, :s]
Enum.sort(enum) |> IO.inspect()

# sort_by
e = [a: 90, b: 99, c: 75, d: 77, f: 90, e: 90, g: 90, h: 100]
Enum.sort_by(e, fn {_, b} -> b end) |> IO.inspect()

Enum.max_by(e, fn {_, a} -> a end) |> IO.inspect()
