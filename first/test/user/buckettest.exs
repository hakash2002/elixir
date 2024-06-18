defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = User.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert User.Bucket.get(bucket, "Haks") == nil

    User.Bucket.put(bucket, "Haks", ["haks@2002","24/11/2002"])
    assert User.Bucket.get(bucket, "Haks") == ["haks@2002","24/11/2002"]
  end
end
