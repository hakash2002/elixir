defmodule TcpServerTest do
  use ExUnit.Case

  test "accepting ports" do
    opts = [:binary, packet: :line, active: false]
    assert {:ok, _socket} = :gen_tcp.connect(~c'localhost', 4040, opts)
  end
end
