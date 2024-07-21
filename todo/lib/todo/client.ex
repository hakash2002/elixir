defmodule Todo.Client do
  use GenServer

  def start_link(opts \\ %{}) do
    server = Keyword.fetch!(opts, :name)
    GenServer.start_link(Todo.Server, server, opts)
  end

  def get(server, month, day) do
    case :ets.lookup(server, month) do
      [{^day, pid}] ->
        Todo.Bucket.get(pid, day)

      [] ->
        :error
    end
  end

  def lookup(server, month) do
    case :ets.lookup(server, month) do
      [{^position, pid}] -> {:ok, pid}
      [] -> :error
    end
  end

  def create(server, month) do
    GenServer.call(server, {:create, month})
  end

  def put(server, month, day, tasks) do
    GenServer.call(server, {:put, month, day, tasks})
  end

  def delete(server, month) do
    GenServer.call(server, {:delete, month})
  end

  def delete(server, month, day) do
    GenServer.call(server, {:delete, month, day})
  end
end
