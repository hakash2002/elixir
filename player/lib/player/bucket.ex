defmodule Player.Bucket do
  use Agent

  def start_link(opts) do
    Agent.start_link(fn -> opts end)
  end

  def get(state, pname) do
    Agent.get(state, fn state -> state[pname] end)
  end

  def put(state, pname, value) do
    Agent.update(state, fn map -> Map.put(map,pname,value) end)
  end

  def delete(state, pname) do
    Agent.get_and_update(state, fn state -> Map.delete(state, pname) end)
  end
end
