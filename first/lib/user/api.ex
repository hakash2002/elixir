defmodule User.Api do
  use GenServer

  @impl true
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
      {:ok, bucket} = User.Bucket.start_link([value])
      {:noreply, Map.put(state, name, bucket)}
    end
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok,opts)
  end

  def get(server, uname) do
    GenServer.call(server, {:lookup, uname})
  end

  def create(server, uname, value) do
    GenServer.cast(server, {:create, uname, value})
  end

  def update(server, uname, value) do
    GenServer.cast(server, {:create, uname, value})
  end
end
