defmodule Tcp_serverTest do
  use ExUnit.Case
  doctest Tcp_server

  test "greets the world" do
    assert Tcp_server.hello() == :world
  end
end
