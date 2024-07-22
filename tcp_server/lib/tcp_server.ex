defmodule Tcp_server do
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
      Task.Supervisor.start_child(Tcpserver.TaskSupervisor, fn -> serve_client(socket) end)

    :ok = :gen_tcp.controlling_process(client, pid)
    loop_accept(socket)
  end

  defp serve_client(socket) do
    write_client(socket, {:ok, "Login to get started.."})
    valid_client(socket, false)

  end

  defp write_client(socket, {:ok, data}) do
    :gen_tcp.send(socket, data)
  end

  defp read_client(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  defp valid_client(socket, false) do
    write_client(socket, {:ok, "Please enter your username: "})
    uname = read_client(socket)
    write_client(socket,{:ok,"Enter password: "})
    pass = read_client(socket) |> String.trim() |> String.to_integer()
    k = Injurypred.User.exists(uname, pass)

    if not k do
      write_client(socket,{:ok,"Invalid username or password: "})
      valid_client(socket, false)
      write_client(socket,{:ok,"Your timer for game starts now: "})
    end

    valid_client(socket, true)
  end

  defp valid_client(socket, true) do
    write_client(socket,{:ok,"Welcome abroad chief!"})
  end
end
