defmodule Author do
  defstruct name: "", age: 20, publications: 0
end

defmodule Books do
  defstruct name: "", author: %Author{}
end

defmodule Library do
  defstruct books: []
end

defprotocol Description do
  def describe(a)
end

defimpl Description, for: Author do
  def describe(%Author{name: name, age: age, publications: p}) do
    "The author #{name} whose age is #{age} has #{p} publications"
  end
end

defimpl Description, for: Books do
  def describe(%Books{name: bname, author: %Author{name: name, age: age, publications: p}}) do
    "The book #{bname} written by #{Description.describe(%Author{name: name, age: age, publications: p})}"
  end
end

defimpl Description, for: Library do
  def describe(a) do
    %Library{books: books} = a

    "Books in this library are: " <> "\n" <>
      Enum.reduce(books, "", fn a, acc -> Description.describe(a) <> "\n" <> acc end)
  end
end

defmodule Out do

  m = %Library{
    books: [
      %Books{name: "Harry potter", author: %Author{name: "Haks", age: 22, publications: 20}},
      %Books{name: "Harry potter", author: %Author{name: "Haks", age: 22, publications: 20}},
      %Books{name: "Harry potter", author: %Author{name: "Haks", age: 22, publications: 20}}
    ]
  }

  IO.puts(Description.describe(m))
end
