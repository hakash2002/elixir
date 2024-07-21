defmodule TcpServer do
  alias Mix.Task
  require Logger

  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("Server connection started, accepting connections on #{port}")
    loop_accept(socket)
  end

  defp loop_accept(socket) do
    {:ok, client} = :gen_tcp.accept(socket)

    {:ok, pid} =
      Task.Supervisor.start_child(TcpServer.TaskSupervisor, fn -> serve_client(client) end)

    :ok = :gen_tcp.controlling_process(client, pid)
    loop_accept(socket)
  end

  defp serve_client(socket) do
    write_client(socket, {:ok, "Please login to continue..\r\n"})
    write_client(socket, {:ok, "Enter your username: "})
    uname = read_client(socket) |> String.trim()
    write_client(socket, {:ok, "Enter password: "})
    pass = read_client(socket) |> String.trim() |> String.to_integer()
    valid_client(socket, uname, pass)
    :gen_tcp.recv(socket, 0, 34000)
  end

  defp write_client(socket, {:ok, data}) do
    :gen_tcp.send(socket, data)
  end

  defp write_client(_socket, {:error, :closed}) do
    exit(:shutdown)
  end

  defp read_client(socket, timeout \\ :infinity) do
    {:ok, data} = :gen_tcp.recv(socket, 0, timeout)
    data
  end

  defp valid_client(socket, uname, pass) do
    if Injurypred.User.exists(uname, pass) do
      write_client(socket, {:ok, "Invalid username or password\r\n "})
      write_client(socket, {:ok, "Re-enter your username: "})
      uname = read_client(socket) |> String.trim()
      write_client(socket, {:ok, "Re-enter password: "})
      pass = read_client(socket) |> String.trim() |> String.to_integer()
      valid_client(socket, uname, pass)
    else
      write_client(socket, {:ok, "Welcome abroad chief!\r\n"})
      write_client(socket, {:ok, "\r\n"})
      write_client(socket, {:ok, "You have to pick 2-5 players from a list of 10 players.\r\n"})

      write_client(
        socket,
        {:ok, "Enter serial number of your picks as comma separated values\r\n"}
      )

      write_client(socket, {:ok, "\r\n"})

      write_client(
        socket,
        {:ok,
         "NOTE: You will be disqualified if you misenter any number or failed to pick minimum 2 players!!!\r\n"}
      )

      write_client(socket, {:ok, "The players are: \r\n"})
      #selectingplayers()
      write_client(socket, {:ok, "Your 30 second timer for the game starts now\r\n "})
    end
  end
"""


  defp selectingplayers() do
    Main.run("lib/injury.csv", "lib/predictions.csv")
    data = Playersparser.select_random_value("../../model/lib/predictions.csv")
    Enum.reduce(data,"", fn %{s_no: a,  player_key: a1,
    player_name: b,
    ruled_out: c},acc -> acc <> "{to_string(a)}, {to_string(a1)} {b}, {c} \n " end)
  end
  """

end
