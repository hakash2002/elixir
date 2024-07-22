defmodule Injurypred.Registry do
  @moduledoc """
  This module uses GenServer to make key-value pair buckets
  """
  use GenServer
  alias Injurypred.Bucket, as: Buck
  @doc """
  Starts the client
  """
  def start_link(opts \\ %{}) do
    server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, server, opts)
  end

  @doc """
  to get the pid of the registered bucket
  """
  def get(server, name) do
    case :ets.lookup(server, name) do
      [{^name, pid}] ->
        {:ok, pid}

      [] ->
        :error
    end
  end

  @doc """
  To get the score of the client
  """
  def getscores(server, name) do
    case get(server, "scores") do
      {:ok, pid} ->
          Buck.getscores(pid,name)

      :error ->
        "User details not exists"
    end
  end

  @doc """
  To update client's score
  """
  def putscores(server, name, score) do
    case get(server, "scores") do
      {:ok, pid} ->
        Buck.put(server, name, score)

      [] ->
        {:ok, pid} =
          DynamicSupervisor.start_child(
            Injurypred.BucketSupervisior,
            {Buck, %{name => score}}
          )

        ref = Process.monitor(pid)
        refs = Map.put(refs, ref, "scores")
        :ets.insert(names, {"scores", pid})
        {:reply, pid, {names, refs}}
    end
  end

  @doc """
  Server-side implementation
  """
  @impl true
  def init(table) do
    names = :ets.new(table, [:named_table, read_concurrency: true])
    refs = %{}
    {:ok, {names, refs}}
  end

  @doc """
  To create a new bucket
  """
  @impl true
  def handle_call({:create, name}, _from, {names, refs}) do
    case get(names, name) do
      {:ok, pid} ->
        {:reply, pid, state}

      :error ->
        {:ok, pid} =
          DynamicSupervisor.start_child(Injurypred.BucketSupervisor, {Buck, []})

        ref = Process.monitor(pid)
        refs = Map.put(refs, ref, name)
        :ets.insert(names, {name, pid})
        {:reply, pid, {names, refs}}
    end
  end

  @doc """
  Put picks into bucket.
  """
  @impl true
  def handle_call({:put, name, picks}, from, {names, refs}) do
    case get(names, name) do
      {:ok, pid} ->
        Buck.put(picks)
        {:reply, :ok, {names, refs}}

      :error ->
        {:reply, "Not found", {names, refs}}
    end
  end

  @doc """
  Delete picks.
  """
  @impl true
  def handle_call({:delete, name}, from, {names, refs}) do
    case get(names, name) do
      {:ok, pid} ->
        Buck.delete(pid, name)
        {:reply, :ok, {names, refs}}

      :error ->
        {:reply, "Not found", {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    :ets.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
