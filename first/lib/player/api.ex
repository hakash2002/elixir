defmodule Player.Api do
  use GenServer

  # Server side
  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:lookup, position, pname}, _from, state) do
    {names, _} = state
    if names[position] do
    {:reply, Player.Bucket.get(names[position], pname), state}
    else
      {:reply,:error,state}
    end
  end

  @impl true
  def handle_call({:lookup,position}, _from, state) do
    {names , _} = state
    {:reply, Map.fetch(names,position), state}
  end

  @impl true
  def handle_cast({:create, position, pname, value}, {names, refs}) do
    if Map.has_key?(names, position) do
      Player.Bucket.put(names[position], pname, value)
      {:noreply, {names, refs}}
    else
      {:ok, bucket} = Player.Bucket.start_link(%{pname => value})
      ref = Process.monitor(bucket)
      refs = Map.put(refs, ref, position)
      names = Map.put(names, position, bucket)
      {:noreply, {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {position, refs} = Map.pop(refs, ref)
    names = Map.delete(names, position)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(msg, state) do
    require Logger
    Logger.debug("Unexpected message in KV.Registry: #{inspect(msg)}")
    {:noreply, state}
  end

  # Client side
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def getplayerdetails(server, position, pname) do
    GenServer.call(server, {:lookup, position, pname})
  end

  def getposition(server, position) do
    GenServer.call(server, {:lookup, position})
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
