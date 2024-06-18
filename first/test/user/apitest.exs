defmodule User.Apitest do
  use ExUnit.Case, async: true

  setup do
    registry = start_supervised!(User.Api)
    %{registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert User.Api.get(registry, "Haks") == :error

    User.Api.create(registry, "Haks",["haks@2002","24/11/2002"])
    assert {:ok, bucket} =  User.Api.get(registry,"Haks")

    User.Bucket.put(bucket, "Haks",["haks@2002","24/11/2002"] )
    assert User.Bucket.get(bucket, "Haks") == ["haks@2002","24/11/2002"]
  end
end
