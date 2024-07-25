defmodule Injury.MainTest do
  @moduledoc """
  Testing if prediction file is generated
  """

  use ExUnit.Case

  test "application check" do
    output_path = Path.join(:code.priv_dir(:injuryprediction), "predictions.csv")
    source_path = Path.join(:code.priv_dir(:injuryprediction), "injury.csv")

    assert Injury.Main.run(
             source_path,
             output_path
           ) == "written to the file#{output_path}"
  end
end
