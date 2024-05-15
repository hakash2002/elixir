defmodule Employee do
  defstruct id: 1001, name: "Hem", doj: "12-11-2022", salary: 40000

  def createnew(id, name, doj, salary) do
    emp = %Employee{id: id, name: name, doj: doj, salary: salary}
    emp
  end
end

defmodule Manager do
  defstruct id: 2000, name: "Hem", doj: "12-11-2022", salary: 100_000

  def createnew(id, name, doj, salary) do
    k = %Manager{id: id, name: name, doj: doj, salary: salary}
    k
  end
end

defprotocol Bonus do
  @doc """
  Calculates bonus
  """
  def bonus(id)
end

defimpl Bonus, for: Employee do
  @doc """
  Calculates bonus for employee
  """
  def bonus(id) do
    n = id.salary * 1.1
    "Salary after bonus is " <> Integer.to_string(round(n))
  end
end

defimpl Bonus, for: Manager do
  @doc """
  Calculates bonus for manager
  """
  def bonus(id) do
    n = id.salary * 1.5
    "Salary after bonus is " <> Integer.to_string(round(n))
  end
end

id = IO.gets("ID: ") |> String.trim()
name = IO.gets("Name: ") |> String.trim()
doj = IO.gets("DOJ: ") |> String.trim()
salary = IO.gets("Salary: ") |> String.trim() |> String.to_integer()

IO.inspect(Employee.createnew(id, name, doj, salary))
IO.inspect(Manager.createnew(id, name, doj, salary))

emp1 = Employee.createnew(id, name, doj, salary)
man1 = Manager.createnew(id, name, doj, salary)

IO.puts(Bonus.bonus(emp1))
IO.puts(Bonus.bonus(man1))
