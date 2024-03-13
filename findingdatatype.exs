x = true

y =
  cond do
    is_atom(x) ->
      "It is atom"

    is_boolean(x) ->
      "It is boolean"

    is_float(x) ->
      "It is float"

    is_function(x) ->
      "It is function"

    is_integer(x) ->
      "It is integer"

    is_list(x) ->
      "It is list"

    is_tuple(x) ->
      "It is tuple"

    is_binary(x) ->
      "It is string"
  end

IO.puts(y)
