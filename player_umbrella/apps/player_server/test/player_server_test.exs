defmodule PlayerServerTest do
  use ExUnit.Case
  @moduletag :capture_log

  setup do
    Application.stop(:player)
    :ok = Application.start(:player)
  end

  setup do
    opts = [:binary, packet: :line, active: false]
    {:ok, socket} = :gen_tcp.connect(~c'localhost', 4040, opts)
    %{socket: socket}
  end

  test "server interaction", %{socket: socket} do
    assert send_and_recv(socket, "UNKNOWN offense\r\n") ==
           "UNKNOWN COMMAND\r\n"

    assert send_and_recv(socket, "GET offense justin jefferson\r\n") ==
           "NOT FOUND\r\n"

    assert send_and_recv(socket, "CREATE offense\r\n") ==
           "OK\r\n"

    assert send_and_recv(socket, "PUT offense justin jefferson 90 90 90\r\n") ==
           "Updated\r\n"

    # GET returns two lines
    assert send_and_recv(socket, "GET offense justin jefferson\r\n") == "Player stats: Power: 90 Speed: 90 Agility: 90\r\n"
    assert send_and_recv(socket, "") == "OK\r\n"

    assert send_and_recv(socket, "DELETE offense justin jefferson\r\n") ==
           "Deleted\r\n"

    # GET returns two lines
    assert send_and_recv(socket, "GET offense justin jefferson\r\n") == "No value found\r\n"
    assert send_and_recv(socket, "") == "OK\r\n"
  end

  defp send_and_recv(socket, command) do
    :ok = :gen_tcp.send(socket, command)
    {:ok,data} = :gen_tcp.recv(socket, 0,1000)
    data
  end
end
