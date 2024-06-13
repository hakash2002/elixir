defmodule User.Serverapi do
  use GenServer

  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {:reply, Map.fetch(state, name), state}
  end

  @impl true
  def handle_cast({:create, name, value}, state) do
    if Map.has_key?(state, name) do
      {:noreply, state}
    else
      {:ok, bucket} = Agent.start_link(fn -> value end)
      {:noreply, Map.put(state, name, bucket)}
    end
  end

  @impl true
  def handle_cast({:update, name, value}, state) do
    pid = Map.get(state,name)
    {Agent.update(pid, fn _ -> value end),state}
  end
end
