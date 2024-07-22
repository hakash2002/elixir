defmodule Todo.Server do
  alias Todo.Client, as: Client
  @impl true
  def init(table) do
    months = :ets.new(table, [:named_table, read_concurrency: true])
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call({:create, month}, _from, {months, refs}) do
    case Client.get(months, month) do
      {:ok, pid} ->
        {:reply, pid, {months, refs}}

      :error ->
        date = Date.utc_today()
        diff = Date.diff(date, Date.end_of_month(date))
        map = adddates(%{}, date, 0, diff)

        {:ok, pid} =
          DynamicSupervisor.start_child(
            Todo.BucketSupervisor,
            {Todo.Bucket, map}
          )

        ref = Process.monitor(pid)
        refs = Map.put(refs, ref, month)
        :ets.insert(months, {month, pid})
        {:reply, pid, {months, refs}}
    end
  end

  @impl true
  def handle_call({:put, month, day, tasks}, _from, {months, refs}) do
    case Client.get(months, month) do
      {:ok, pid} ->
        Todo.Bucket.put(pid,day,tasks)
        {:reply, pid, {months, refs}}

      :error ->
        {:reply, "Day doesn't exist", {months, refs}}
    end
  end

  def adddates(map, date, acc, num) when acc < num do
    map = Map.put(map, Date.add(date, num), "No tasks added")
    adddates(map, date, acc + 1, num)
  end

  def adddates(map, date, acc, num) when acc == num do
    map
  end
end
