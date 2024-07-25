defmodule Injurypred.Bucket do
  @moduledoc """
  Various actions on buckets
  """
  use Agent, restart: :temporary

  def start_link(opts) do
    Agent.start_link(fn -> opts end)
  end

  def get(state) do
    Agent.get(state, fn data -> data end)
  end

  def put(state, value) do
    Agent.update(state, fn _data -> value end)
  end

  def delete(state) do
    Agent.update(state, fn _data -> [] end)
  end

  def getscores(state, key) do
    Agent.get(state, fn state -> Map.fetch(state, key) end)
  end

  def putscore(state, key, value) do
    Agent.update(state, fn state -> Map.put(state, key, value) end)
  end

  def getuserstatus(state, key, user) do
    Agent.get(state, &fetch_user_status(&1, key, user))
  end

  defp fetch_user_status(state, key, user) do
    case Map.fetch(state, key) do
      {:ok, val} -> user in val
      :error -> false
    end
  end

  def updateuserstatus(state, key, value) do
    Agent.update(state, fn state ->
      {:ok, va} = Map.fetch(state, key)
      Map.put(state, key, [value | va])
    end)
  end

  def delete(state, key, uname) do
    Agent.update(state, fn state ->
      Map.put(state, key, List.delete(Map.get(state, key), uname))
    end)
  end
end
