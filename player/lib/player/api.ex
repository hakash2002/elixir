defmodule Player.Api do
  use GenServer

  # Clientside
  def start_link(opts \\ %{}) do
    server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, server, opts)
  end

  def getplayerdetails(server, position, pname) do
    case :ets.lookup(server, position) do
      [{^position, pid}] ->
        Player.Bucket.get(pid, pname)

      [] ->
        :error
    end
  end

  def getposition(server, position) do
    case :ets.lookup(server, position) do
      [{^position, pid}] -> {:ok, pid}
      [] -> :error
    end
  end

  def create(server, position, pname, power, speed, agility) do
    value = [power: power, speed: speed, agility: agility]
    GenServer.call(server, {:create, position, pname, value})
  end

  def update(server, position, pname, power, speed, agility) do
    value = [power: power, speed: speed, agility: agility]
    GenServer.call(server, {:create, position, pname, value})
  end

  # Server side
  @impl true
  def init(table) do
    names = :ets.new(table, [:named_table, read_concurrency: true])
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:create, position, pname, value}, _from, {names, refs}) do
    case getposition(names, position) do
      {:ok, pid} ->
        Player.Bucket.put(pid, pname, value)
        {:reply, pid, {names, refs}}

      :error ->
        {:ok, pid} =
          DynamicSupervisor.start_child(
            Player.BucketSupervisor,
            {Player.Bucket, %{pname => value}}
          )

        ref = Process.monitor(pid)
        refs = Map.put(refs, ref, position)
        :ets.insert(names, {position, pid})
        {:reply, pid, {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    # 6. Delete from the ETS table instead of the map
    {name, refs} = Map.pop(refs, ref)
    :ets.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
