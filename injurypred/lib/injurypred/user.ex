defmodule Injurypred.User do
  defstruct pname: nil, password: nil

  def data() do
    [
      %Injurypred.User{name: "Neil", password: 1234},
      %Injurypred.User{name: "hakash", password: 1234},
      %Injurypred.User{name: "vignesh", password: 1234},
      %Injurypred.User{name: "aswanth", password: 1234},
      %Injurypred.User{name: "random", password: 1234}
    ]
  end

end
