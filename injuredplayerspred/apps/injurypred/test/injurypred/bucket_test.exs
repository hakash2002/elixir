defmodule InjuryPred.BucketTest do
  use ExUnit.Case, async: true
  alias Injurypred.Bucket

  setup do
    {:ok, bucket} = Injurypred.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert Bucket.get(bucket) == []

    Bucket.put(bucket, [
      %{player_key: "44449", player_name: "Keisean Nixon+"},
      %{player_key: "43518", player_name: "James Mitchell"},
      %{player_key: "47287", player_name: "Mike White"},
      %{player_key: "35611", player_name: "Rodney McLeod"},
      %{player_key: "46394", player_name: "Tariq Woolen"}
    ])

    assert Bucket.get(bucket) == [
             %{player_key: "44449", player_name: "Keisean Nixon+"},
             %{player_key: "43518", player_name: "James Mitchell"},
             %{player_key: "47287", player_name: "Mike White"},
             %{player_key: "35611", player_name: "Rodney McLeod"},
             %{player_key: "46394", player_name: "Tariq Woolen"}
           ]

    Bucket.delete(bucket)
    assert Bucket.get(bucket) == []

    {:ok, bucket} = Bucket.start_link(%{})
    assert Bucket.putscore(bucket, "hakash", 100) == :ok
    assert Bucket.getscores(bucket, "hakash") == {:ok, 100}

    {:ok, bucket} =
      Bucket.start_link(%{"usersonline" => ["hakash", "Neil"], "usersfinished" => ["hakash"]})

    assert Bucket.updateuserstatus(bucket, "usersfinished", "Neil")
    assert Bucket.getuserstatus(bucket, "bogus", "bogus") == false
    assert Bucket.getuserstatus(bucket, "usersfinished", "Neil") == true
    assert Bucket.getuserstatus(bucket, "usersfinished", "Ne") == false

    Bucket.delete(bucket, "usersonline", "hakash")

    assert Bucket.get(bucket) == %{
             "usersonline" => ["Neil"],
             "usersfinished" => ["Neil", "hakash"]
           }
  end
end
