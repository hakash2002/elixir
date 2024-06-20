defmodule Player.Apitest do
  use ExUnit.Case, async: true
  use Agent
  setup do
    registry = start_supervised!(Player.Api)
    %{registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert Player.Api.getplayerdetails(registry, "Offence", "Travis kelce") == :error

    Player.Api.create(registry, "Offence", "Travis kelce", 90, 90, 90)
    assert {:ok, bucket} = Player.Api.getposition(registry, "Offence")

    assert Player.Api.getplayerdetails(registry, "Offence", "Travis kelce") == [
             power: 90,
             speed: 90,
             agility: 90
           ]

    Player.Bucket.put(bucket, "Chase", power: 90, speed: 90, agility: 90)
    assert Player.Bucket.get(bucket, "Chase") == [power: 90, speed: 90, agility: 90]
  end

  test "removes bucket on crash", %{registry: registry} do
    Player.Api.create(registry, "Offence", "Travis kelce", 90, 90, 90)
    {:ok, bucket} = Player.Api.getposition(registry, "Offence")

    Agent.stop(bucket, :shutdown)
    #assert Process.alive?(bucket) == Agent.get(registry,fn s -> s end)
    assert Player.Api.getposition(registry, "Offence") == :error
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(Player.Bucket, %{}).restart == :temporary
  end

end
