defmodule Injurypred.RegistryTest do
  use ExUnit.Case, async: true
  alias Injurypred.Registry, as: Reg

  setup context do
    _ = start_supervised!({Reg, name: context.test})
    %{registry: context.test}
  end

  test "spawns buckets", %{registry: registry} do
    assert Reg.get(registry, "clients") == :error

    Reg.create(registry, "clients")
    assert {:ok, bucket} = Reg.get(registry, "clients")

    Injurypred.Bucket.put(bucket, [
      %{player_key: "44449", player_name: "Keisean Nixon+"},
      %{player_key: "43518", player_name: "James Mitchell"},
      %{player_key: "47287", player_name: "Mike White"},
      %{player_key: "35611", player_name: "Rodney McLeod"},
      %{player_key: "46394", player_name: "Tariq Woolen"}
    ])

    assert Injurypred.Bucket.get(bucket) == [
             %{player_key: "44449", player_name: "Keisean Nixon+"},
             %{player_key: "43518", player_name: "James Mitchell"},
             %{player_key: "47287", player_name: "Mike White"},
             %{player_key: "35611", player_name: "Rodney McLeod"},
             %{player_key: "46394", player_name: "Tariq Woolen"}
           ]
  end

  test "bucket removed on exit", %{registry: registry} do
    Reg.create(registry, "Haks")
    {:ok, pid} = Reg.get(registry, "Haks")
    Agent.stop(pid)
    _ = Reg.create(registry, "Random")
    assert Reg.get(registry, "Haks") == :error
  end

  test "bucket removed on crash", %{registry: registry} do
    Reg.create(registry, "Haks")
    {:ok, pid} = Reg.get(registry, "Haks")
    Agent.stop(pid, :shutdown)
    _ = Reg.create(registry, "Random")
    assert Reg.get(registry, "Haks") == :error
  end

  test "gameflow tests", %{registry: registry} do
    assert {:ok, _pid} = Reg.gameflow(registry)
    assert {:ok, _pid} = Reg.gameflow(registry)
    assert Reg.getscores(registry, "hakash") == :error
    assert Reg.putscores(registry, "hakash", 100) == :ok
    assert Reg.getscores(registry, "hakash") == {:ok, 100}

    Reg.updateuserstatus(registry, "usersonline", "hakash")
    Reg.updateuserstatus(registry, "usersfinished", "hakash")

    Reg.create(registry, "bogus")
    assert Reg.updateuserstatus(registry, "usersonline", "hakash") == "User exists"

    Reg.putscores(registry, "Neil", 90)

    Reg.updateuserstatus(registry, "usersonline", "Neil")
    Reg.updateuserstatus(registry, "usersfinished", "Neil")

    assert Reg.endgame(registry) == true

    assert Reg.findwinner(registry) == {["hakash"], 100}

    Reg.putscores(registry, "Neil", 100)

    assert Reg.findwinner(registry) == {["hakash", "Neil"], 100}
    assert Reg.deleteuser(registry, "hakash") == :ok
  end
end
