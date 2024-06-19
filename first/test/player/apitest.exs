defmodule Player.Apitest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(Player.Api)
    %{registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    Player.Api.create(registry, "Offence", "Travis kelce", 90, 90, 90)
    Player.Api.create(registry, "Offence", "Kravis kelce", 90, 90, 90)
    assert Player.Api.get(registry, "Offence", "Travis kelce") == :error

    Player.Api.create(registry, "Offence", "Travis kelce", 90, 90, 90)
    assert {:ok, bucket} =  Player.Api.get(registry, "Offence", "Travis kelce")

    Player.Bucket.put(bucket, "Chase", [power: 90, speed: 90, agility: 90])
    assert Player.Bucket.get(bucket, "Chase") == [power: 90, speed: 90, agility: 90]
  end
end
