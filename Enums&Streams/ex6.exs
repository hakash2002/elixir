k = [
  :apple,
  :banana,
  :banana,
  :orange,
  :orange,
  :grape,
  :watermelon,
  :watermelon,
  :strawberry,
  :pineapple,
  :kiwi,
  :mango,
  :peach,
  :peach,
  :pear,
  :plum,
  :cherry,
  :blueberry,
  :raspberry,
  :blackberry,
  :mango,
  :lemon,
  :lime,
  :fig,
  :pomegranate,
  :apricot,
  :cantaloupe,
  :honeydew
]

Stream.dedup(k) |> Enum.to_list() |> IO.inspect()

Enum.uniq(k) |> IO.inspect()

Stream.uniq_by(k, fn a -> String.last(to_string(a)) end) |> Enum.to_list() |> IO.inspect()

Enum.find(k, fn a -> String.length(to_string(a)) > 8 end) |> IO.inspect()

Enum.group_by(k, &String.length(to_string(&1))) |> IO.inspect()

Enum.slice(k, 1..6) |> IO.inspect()

Enum.reverse(k) |> IO.inspect()

Enum.split_with(k,&String.length(to_string(&1)) == 5) |> IO.inspect()
