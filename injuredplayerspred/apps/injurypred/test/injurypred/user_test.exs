defmodule Injurypred.UserTest do
  use ExUnit.Case

  test "checks user exists" do
    assert %Injurypred.User{} = %Injurypred.User{name: nil, password: nil}
    assert Injurypred.User.exists("hakash", 123) == true
    assert Injurypred.User.exists("hakash", 1234) == false
  end
end
