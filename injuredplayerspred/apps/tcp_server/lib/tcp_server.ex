defmodule TcpServer do
  @moduledoc """
  This is the tccp server for handling users
  """
  require Logger

  def accept(port) do
    {:ok, socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("Server connection started, accepting on #{port}")
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
    write_client(socket, {:ok, "\r\n"})
    write_client(socket, {:ok, "You have to pick 2-5 players from a list of 10 players.\r\n"})
    write_client(socket, {:ok, "\r\n"})

    write_client(
      socket,
      {:ok,
       "NOTE: You will be disqualified if you misenter any number or failed to pick minimum 2 players!!!\r\n"}
    )

    {:ok, count} = Agent.start_link(fn -> 1 end)
    loopgame(count, uname, socket)

    Injurypred.Registry.updateuserstatus(Injurypred.Registry, "usersfinished", uname)

    write_client(socket, {:ok, "Waiting for results...\r\n"})
    write_client(socket, {:ok, "\r\n"})
    endgame(socket)
  end

  defp write_client(socket, {:ok, data}) do
    :gen_tcp.send(socket, data)
  end

  defp write_client(_, {:error, :closed}) do
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
      Injurypred.Registry.updateuserstatus(Injurypred.Registry, "usersonline", uname)
    end
  end

  defp selectingplayers() do
    csv_path = Path.join(:code.priv_dir(:injuryprediction), "predictions.csv")

    data =
      Injury.Playersparser.select_random_value(csv_path)

    {Enum.reduce(data, " ", fn %{s_no: a, player_key: _, player_name: b, ruled_out: _}, acc ->
       acc <> "#{to_string(a)}| #{b} \n "
     end), data}
  end

  defp loopgame(count, uname, socket) do
    round_no = Agent.get_and_update(count, fn count -> {count, count + 1} end)

    if round_no < 4 do
      write_client(socket, {:ok, "-------------------- \r\n"})
      write_client(socket, {:ok, "Round no: #{to_string(round_no)} \r\n"})
      write_client(socket, {:ok, "-------------------- \r\n"})
      write_client(socket, {:ok, "The players are: \r\n"})
      write_client(socket, {:ok, "S.No | Player name\r\n"})
      {tobewritten, datas} = selectingplayers()
      write_client(socket, {:ok, tobewritten})

      write_client(
        socket,
        {:ok, "Enter serial number of your picks as comma separated values\r\n"}
      )

      write_client(socket, {:ok, "Your 30 second timer for the game starts now\r\n "})
      write_client(socket, {:ok, "Enter picks: "})

      data =
        try do
          to_string(read_client(socket, 34_000))
          |> String.trim()
          |> String.split(",")
          |> Enum.map(&String.to_integer/1)
          |> Enum.filter(fn s -> s < 11 end)
          |> Enum.uniq()
        rescue
          ArgumentError ->
            Injurypred.Registry.deleteuser(Injurypred.Registry, uname)
            write_client(socket, {:ok, "You are disqualified\r\n"})
            write_client(socket, {:error, :closed})

          MatchError ->
            Injurypred.Registry.deleteuser(Injurypred.Registry, uname)
            write_client(socket, {:ok, "You are disqualified\r\n"})
            write_client(socket, {:error, :closed})
        end

      dat =
        if length(data) > 5 do
          Enum.slice(data, 0, 5)
        else
          data
        end

      score = Injury.Playersparser.predict_score(datas, dat)

      if round_no == 1 do
        Injurypred.Registry.putscores(Injurypred.Registry, uname, score)
      else
        {:ok, val} = Injurypred.Registry.getscores(Injurypred.Registry, uname)
        Injurypred.Registry.putscores(Injurypred.Registry, uname, score + val)
      end

      {:ok, updated_score} = Injurypred.Registry.getscores(Injurypred.Registry, uname)
      write_client(socket, {:ok, "Your score in this round: #{to_string(score)}\r\n"})
      write_client(socket, {:ok, "Your cummulative score is: #{to_string(updated_score)}\r\n"})
      loopgame(count, uname, socket)
    end
  end

  defp endgame(socket) do
    if Injurypred.Registry.endgame(Injurypred.Registry) do
      {val, maxscore} = Injurypred.Registry.findwinner(Injurypred.Registry)
      winner = Enum.reduce(val, "", fn val, acc -> " " <> acc <> val end)

      if length(val) > 1 do
        write_client(
          socket,
          {:ok, "The winners are#{winner} with score of #{to_string(maxscore)}\r\n"}
        )
      else
        write_client(
          socket,
          {:ok, "The winner is#{winner} with a score of #{to_string(maxscore)}\r\n"}
        )
      end
    else
      endgame(socket)
    end
  end
end
