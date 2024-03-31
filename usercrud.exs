defmodule User do
  def readuser(userid, users) do
    "#{userid} details:
    Firstname: #{users[userid].fname}
    Lastname: #{users[userid].lname}
    Date of birth: #{users[userid][:DOB]}
    Age: #{users[userid].age}"
  end

  def createuser(userid, fname, lname, age, dob) do
    user = [{userid, %{fname: fname, lname: lname, age: age, DOB: dob}}]
    user
  end

  def updateuser(userid, fname, lname, age, dob, users) do
    user = put_in(users[userid], %{fname: fname, lname: lname, age: age, DOB: dob})
    user
  end

  def deleteuser(userid, users) do
    user = Keyword.delete(users, userid)
    user
  end
end

users = [
  haks: %{fname: "Hakash", lname: "Dhana", age: 22, DOB: "24-11-2002"},
  ramesh: %{fname: "Ramesh", lname: "Suresh", age: 30, DOB: "11-10-1994"},
  dins: %{fname: "Dinesh", lname: "Kuresh", age: 40, DOB: "19-09-1984"}
]

userid = String.to_atom(IO.gets("Enter your userid: ") |> String.trim())

{message, updatedusers} =
  if users[userid] do
    val = String.to_integer(IO.gets("What would you like to do?
  type
    1: to create new user
    2: to read your user data
    3: to update your userid
    4: to delete your userid
    Enter: ") |> String.trim())

    case val do
      1 ->
        userid = String.to_atom(IO.gets("Enter userid: ") |> String.trim())

        if users[userid] do
          {"Userid exists please try another one", users}
        else
          fname = IO.gets("Enter firstname: ") |> String.trim()
          lname = IO.gets("Enter lastname: ") |> String.trim()
          age = String.to_integer(IO.gets("Enter age: ") |> String.trim())
          dob = IO.gets("Enter DOB (format : dd-mm-yyyy): ") |> String.trim()
          updatedusers = users ++ User.createuser(userid, fname, lname, age, dob)
          IO.puts("User created successfully")
          {User.readuser(userid, updatedusers), updatedusers}
        end

      2 ->
        {User.readuser(userid, users), users}

      3 ->
        IO.puts("----------------------------------------------------------------------")
        IO.puts("Existing data is:
        #{User.readuser(userid, users)}")
        IO.puts("----------------------------------------------------------------------")
        updateinfo = String.to_integer(IO.gets("Enter what you want to update:
              Type:
                 1: Firstname
                 2: Second name
                 3: Age
                 4: DOB
                Enter: ") |> String.trim())
        data = IO.gets("Enter the new value: ") |> String.trim()
        %{fname: x, lname: y, age: z, DOB: p} = users[userid]
        user =
          case updateinfo do
            1 ->
              User.updateuser(userid, data, y, z, p, users)

            2 ->
              User.updateuser(userid, x, data, z, p, users)

            3 ->
              User.updateuser(userid, x, y, data, p, users)

            4 ->
              User.updateuser(userid, x, y, z, data, users)
          end
          updatedusers = user
          {"Data after updating:
        #{User.readuser(userid, updatedusers)}",updatedusers}
      4 ->
        updatedusers = User.deleteuser(userid,users)
        {"Successfully deleted",updatedusers}
    end
  else
    {"Invalid userid", users}
  end
users = updatedusers
IO.puts("----------------------------------------------------------------------")
IO.puts(message)
IO.puts("----------------------------------------------------------------------")
IO.puts("User data: ")
IO.inspect(users)
