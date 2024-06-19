defmodule Player.Api do
  use GenServer

  # Server side
  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, position, pname}, _from, state) do
    pid = state[position]
    value = Player.Bucket.get(pid,pname)
    {:reply,value,state}
  end

  @impl true
  def handle_cast({:create, position, pname, value}, state) do
    if Map.has_key?(state, position) do
      Player.Bucket.put(state[position], pname, value)
      {:noreply, state}
    else
      {:ok, bucket} = Player.Bucket.start_link(%{pname => value})
      {:noreply, Map.put(state, position, bucket)}
    end
  end

  # Client side
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get(server, position, pname) do
    GenServer.call(server, {:lookup, position, pname})
  end

  def create(server, position, pname, power, speed, agility) do
    value = [power: power, speed: speed, agility: agility]
    GenServer.cast(server, {:create, position, pname, value})
  end

  def update(server, position, pname, power, speed, agility) do
    value = [power: power, speed: speed, agility: agility]
    GenServer.cast(server, {:create, position, pname, value})
  end
end
