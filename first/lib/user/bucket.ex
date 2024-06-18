defmodule User.Bucket do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> [] end)
  end

  def get(bucket, uname) do
    Agent.get(bucket, fn bucket -> Map.get(bucket, uname) end)
  end

  def put(bucket, uname, value) do
    Agent.update(bucket, fn bucket -> Map.put(bucket, uname, value) end)
  end

  def delete(bucket, uname) do
    Agent.get_and_update(bucket,fn bucket -> Map.delete(bucket, uname) end)
  end
end
