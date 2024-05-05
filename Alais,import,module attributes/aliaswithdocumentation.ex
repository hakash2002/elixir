defmodule Team do
  @moduledoc """
  Module contains various modules on various formats of international cricket of BCC
  """
  defmodule Odi do
    @moduledoc """
    Module contains various modules on batters, bowlers, all-rounders in ODI format
    """
    defmodule Batters do
      @moduledoc """
      Contains batsman insights
      """
      defp get_batters() do
        [
          rohit: %{SR: 150, Centuries: 75, Fifties: 75, jersey_no: 45},
          virat: %{SR: 150, Centuries: 79, Fifties: 50, jersey_no: 18},
          dhawan: %{SR: 140, Centuries: 40, Fifties: 75, jersey_no: 42},
          shreyas: %{SR: 130, Centuries: 20, Fifties: 30, jersey_no: 96},
          pant: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
          klrahul: %{SR: 130, Centuries: 10, Fifties: 40, jersey_no: 1}
        ]
      end
      @doc """
      returns insights about the batsman
      """
      def getdetails(a) do
        get_batters()[a]
      end
    end

    defmodule Bowlers do
      @moduledoc """
      Contains bowler insights
      """
      defp get_bowlers() do
        [
          bumrah: %{SR: 30, threefers: 20, fifers: 10, jersey_no: 93},
          ashwin: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 99},
          shami: %{SR: 28, threefers: 15, fifers: 7, jersey_no: 12},
          siraj: %{SR: 27, threefers: 10, fifers: 4, jersey_no: 11},
          chahal: %{SR: 20, threefers: 21, fifers: 12, jersey_no: 111},
          kuldeep: %{SR: 30, threefers: 15, fifers: 12, jersey_no: 23}
        ]
      end

      @doc """
      returns insights about the batsman
      """
      def getdetails(a) do
        get_bowlers()[a]
      end
    end
    defmodule Allrounders do
      defp get_allrounders() do
        [
          hardik: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          jaddu: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          dube: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          thakur: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ]
        ]
      end

      def getdetails(a) do
        get_allrounders()[a]
      end
    end
  end

  defmodule T20 do
    @moduledoc """
    Module contains various modules on batters, bowlers, all-rounders in T20 format
    """
    defmodule Batters do
      @moduledoc """
      Contains batsman insights
      """
      defp get_batters() do
        [
          rohit: %{SR: 150, Centuries: 75, Fifties: 75, jersey_no: 45},
          virat: %{SR: 150, Centuries: 79, Fifties: 50, jersey_no: 18},
          dhawan: %{SR: 140, Centuries: 40, Fifties: 75, jersey_no: 42},
          shreyas: %{SR: 130, Centuries: 20, Fifties: 30, jersey_no: 96},
          pant: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
          klrahul: %{SR: 130, Centuries: 10, Fifties: 40, jersey_no: 1}
        ]
      end
      @doc """
      returns insights about the batsman
      """
      def getdetails(a) do
        get_batters()[a]
      end
    end

    defmodule Bowlers do
      @moduledoc """
      Contains bowler insights
      """
      defp get_bowlers() do
        [
          bumrah: %{SR: 30, threefers: 20, fifers: 10, jersey_no: 93},
          ashwin: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 99},
          shami: %{SR: 28, threefers: 15, fifers: 7, jersey_no: 12},
          siraj: %{SR: 27, threefers: 10, fifers: 4, jersey_no: 11},
          chahal: %{SR: 20, threefers: 21, fifers: 12, jersey_no: 111},
          kuldeep: %{SR: 30, threefers: 15, fifers: 12, jersey_no: 23}
        ]
      end

      @doc """
      returns insights about the batsman
      """
      def getdetails(a) do
        get_bowlers()[a]
      end
    end
    defmodule Allrounders do
      defp get_allrounders() do
        [
          hardik: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          jaddu: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          dube: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          thakur: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ]
        ]
      end

      def getdetails(a) do
        get_allrounders()[a]
      end
    end
  end

  defmodule Test do
    @moduledoc """
    Module contains various modules on batters, bowlers, all-rounders in Test format
    """
    defmodule Batters do
      @moduledoc """
      Contains batsman insights
      """
      defp get_batters() do
        [
          rohit: %{SR: 150, Centuries: 75, Fifties: 75, jersey_no: 45},
          virat: %{SR: 150, Centuries: 79, Fifties: 50, jersey_no: 18},
          dhawan: %{SR: 140, Centuries: 40, Fifties: 75, jersey_no: 42},
          shreyas: %{SR: 130, Centuries: 20, Fifties: 30, jersey_no: 96},
          pant: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
          klrahul: %{SR: 130, Centuries: 10, Fifties: 40, jersey_no: 1}
        ]
      end
      @doc """
      returns insights about the batsman
      """
      def getdetails(a) do
        get_batters()[a]
      end
    end

    defmodule Bowlers do
      @moduledoc """
      Contains bowler insights
      """
      defp get_bowlers() do
        [
          bumrah: %{SR: 30, threefers: 20, fifers: 10, jersey_no: 93},
          ashwin: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 99},
          shami: %{SR: 28, threefers: 15, fifers: 7, jersey_no: 12},
          siraj: %{SR: 27, threefers: 10, fifers: 4, jersey_no: 11},
          chahal: %{SR: 20, threefers: 21, fifers: 12, jersey_no: 111},
          kuldeep: %{SR: 30, threefers: 15, fifers: 12, jersey_no: 23}
        ]
      end

      @doc """
      returns insights about the batsman
      """
      def getdetails(a) do
        get_bowlers()[a]
      end
    end
    defmodule Allrounders do
      defp get_allrounders() do
        [
          hardik: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          jaddu: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          dube: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ],
          thakur: [
            bat: %{SR: 170, Centuries: 7, Fifties: 20, jersey_no: 17},
            bowl: %{SR: 29, threefers: 40, fifers: 9, jersey_no: 17}
          ]
        ]
      end

      def getdetails(a) do
        get_allrounders()[a]
      end
    end
  end
end

alias Team.Odi.Batters, as: Bat
IO.inspect(Bat.getdetails(:virat))

alias Team.Odi.Bowlers, as: Bowl
IO.inspect(Bowl.getdetails(:bumrah))

alias Team.Odi.Allrounders, as: Allr
IO.inspect(Allr.getdetails(:dube))

IO.puts("-------------------------------------------------------")

alias Team.T20.Batters, as: Bat
IO.inspect(Bat.getdetails(:virat))

alias Team.T20.Bowlers, as: Bowl
IO.inspect(Bowl.getdetails(:bumrah))

alias Team.T20.Allrounders, as: Allr
IO.inspect(Allr.getdetails(:dube))

IO.puts("--------------------------------------------------------")

alias Team.Test.Batters, as: Bat
IO.inspect(Bat.getdetails(:virat))

alias Team.Test.Bowlers, as: Bowl
IO.inspect(Bowl.getdetails(:bumrah))

alias Team.Test.Allrounders, as: Allr
IO.inspect(Allr.getdetails(:dube))
