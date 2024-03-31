x = 7

y =
  case x do
    1 ->
      "The day is Sunday. Happy weekend"

    2 ->
      "The day is Monday"

    3 ->
      "The day is Tuesday"

    4 ->
      "The day is Wednesday"

    5 ->
      "The day is Thursday"

    6 ->
      "The day is Friday"

    7 ->
      "The day is Saturday. Happy weekend"

    _ ->
      "Invalid number"
  end

IO.puts(y)
