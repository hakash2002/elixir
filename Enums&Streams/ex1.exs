defmodule User do
  defp getusers(),
    do: [
      haks: %{fname: "Hakash", lname: "Dhana", age: 22, DOB: "24-11-2002"},
      ramesh: %{fname: "Ramesh", lname: "Suresh", age: 30, DOB: "11-10-1994"},
      dins: %{fname: "Dinesh", lname: "Kuresh", age: 40, DOB: "19-09-1984"}
    ]

  def doesexists(name) do
    Enum.any?(getusers(), fn {s, _} -> s == name end)
  end

  def usersage() do
    Enum.all?(getusers(), fn {_, %{:fname => _,:lname => _, :age => x, :DOB => _}} -> x > 20 end)
  end
end

User.doesexists(:haks) |> IO.puts()
User.usersage() |> IO.puts()
