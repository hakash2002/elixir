defmodule InjurypredictionTest do
  @moduledoc """
    Testing the socket connection

  """

  use ExUnit.Case

  setup do
    Application.stop(:injuryprediction)
    :ok = Application.start(:injuryprediction)
  end

  setup do
    opts = [:binary, packet: :line, active: false]
    {:ok, socket} = :gen_tcp.connect(~c'localhost', 4321, opts)
    %{socket: socket}
  end

  test "server interaction", %{socket: socket} do
    assert send_and_recv(socket, "injury.csv") ==
             "The file you want to read and write the prediction\n"
  end

  defp send_and_recv(socket, command) do
    :ok = :gen_tcp.send(socket, command)
    {:ok, data} = :gen_tcp.recv(socket, 0, 1000)
    data
  end
end
