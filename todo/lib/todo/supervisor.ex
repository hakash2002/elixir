defmodule Todo.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Todo.Client, name: Todo.Client},
      {DynamicSupervisor, name: Todo.BucketSupervisor, strategy: :one_for_one},
      {Task.Supervisor, name: Todo.RouterTasks}
    ]
    Supervisor.init(children, strategy: :one_for_all)
  end
end
