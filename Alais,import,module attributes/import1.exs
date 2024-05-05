defmodule Enums do
  @moduledoc """
  Just a little module
  """
  import Enum
  alias Stream, as: St
  alias String, as: Str


  defp get() do
    [
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
  end
  @doc """
  Does random operations on a List of atoms
  """
  def operations() do
    St.dedup(get()) |> to_list() |> IO.inspect()

    uniq(get()) |> IO.inspect()

    St.uniq_by(get(), fn a -> Str.last(to_string(a)) end) |> to_list() |> IO.inspect()

    find(get(), fn a -> Str.length(to_string(a)) > 8 end) |> IO.inspect()

    group_by(get(), &Str.length(to_string(&1))) |> IO.inspect()

    slice(get(), 1..6) |> IO.inspect()

    import St
    #Will punish us with an error for being ambiguous on using filter() from either Stream or Enum
    get() |> filter(fn a -> Atom.to_string(a) |> Str.contains?("err") end) |> IO.inspect()

  end
end

Enums.operations()
