defmodule Injurypred.Bucket do
  use Agent, restart: :temporary

  def start_link(opts) do
    Agent.start_link(fn -> opts end)
  end

  def get(state) do
    Agent.get(state, fn data -> data end)
  end

  def put(state,value) do
    Agent.put(state, fn _data -> value end)
  end

  def delete(state) do
    Agent.update(state ,fn _data -> [] end)
  end

  def getscores(state, key) do
    Agent.get(state, fn state -> Map.fetch(state, key) end)
  end

end
