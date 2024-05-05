defmodule Files do
  def link() do
    pid = spawn(fn -> Files.fileoperation() end)
    pid
  end

  def fileoperation() do
    receive do
      {:read, pid} ->
        val = File.read("hello.txt")
        send(pid, {:ok, val})

      {:write, pid, value} ->
        file = File.open!("hello.txt", [:write])
        val = IO.write(file, value)
        File.close(file)
        send(pid, val)

      {:append, pid, value} ->
        file = File.open!("hello.txt", [:append])
        val = IO.write(file, value)
        File.close(file)
        send(pid," " <> val)
    end
  end
end
