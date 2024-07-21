defmodule Todo.Bucket do
  use Agent, restart: :temporary

  def start_link(opts) do
    Agent.start_link(fn -> opts end)
  end

  def get(state, day) do
    Agent.get(state, &Map.fetch(&1, day)/2)
  end

  def put(state, day, task) do
    Agent.update(state,&Map.put(&1,day,task)/3)
  end

  def delete(state, day) do
    Agent.update(state, &Map.update)
  end

end
