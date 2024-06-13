defmodule User.Clientapi do
  import Serverapi
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(User.Serverapi, :ok)
  end

  def get(uname) do
    GenServer.call(server, {:lookup, uname})
  end

  def create(uname, value) do
    GenServer.cast(server, {:create, uname, value})
  end

  def update(uname, value) do
    GenServer.cast(server, {:update, uname, value})
  end
end
