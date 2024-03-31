defmodule Banking do
  defp customers(userid) do
    cus = [
      haks: %{balance: 2000, creditscore: 200},
      sanj: %{balance: 1000, creditscore: 100},
      danny: %{balance: 500, creditscore: 50}
    ]

    cus[userid]
  end

  def istransferrable(a, amount) do
    if amount < customers(a).balance do
      "Amount can be transferred"
    else
      "Insufficient balance"
    end
  end

  def idexists(a) do
    if customers(a) do
      true
    else
      false
    end
  end

  def checkbalance(a), do: customers(a).balance

  def iscreditable(a) do
    %{balance: x, creditscore: y} = customers(a)

    if x + y > 1000 do
      "Yes loan can be sanctioned"
    else
      "Sorry try improving your creditscore"
    end
  end
end

a = String.to_atom(IO.gets("Enter your account id: ") |> String.trim())
b = String.to_atom(IO.gets("Enter transfer account id: ") |> String.trim())

if Banking.idexists(a) and Banking.idexists(b) do
  IO.puts("Your balance is: #{Banking.checkbalance(a)}")
  amt = String.to_integer(IO.gets("Enter amount to transfer: ") |> String.trim())
  IO.puts("Checking if transferrable...")
  IO.puts(Banking.istransferrable(a, amt))
  IO.puts("Checking if loan can be sanctioned..")
  IO.puts(Banking.iscreditable(a))
  IO.inspect(Banking.customers(a)) #This specific line will throw private or undefined function error
else
  IO.puts("Enter valid accountid's")
end
