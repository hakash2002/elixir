defmodule Mod1 do
  def something(), do: "Module 1"
  def nothing(), do: "Module 2"

  defmodule Mod2 do
    def really_nothing(), do: "Module 2"
    def really_something(), do: "Module 2"

    defmodule Mod3 do
      def notreally_nothing(), do: "Module 3"
      def notreally_something(), do: "Module 3"
    end
  end

  defmodule Mod11 do
    def something1(), do: "Module 11"
    def nothing1(), do: "Module 11"
  end
end

alias Mod1.{Mod11, Mod2.Mod3}
alias Mod3, as: M3
IO.puts(M3.notreally_nothing())

alias Mod11, as: M3
IO.puts(M3.something1())
