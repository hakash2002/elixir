defmodule Injury.PlayersParserTest do
  @moduledoc """
  Testing if parsing of csv into Enum works fine
  """
  use ExUnit.Case

  test "application check" do
    output_path = Path.join(:code.priv_dir(:injuryprediction), "predictions.csv")

    c =  Injury.Playersparser.select_random_value(output_path)
    d = [1, 2, 3]
    Injury.Playersparser.predict_score(c, d)

  end
end
