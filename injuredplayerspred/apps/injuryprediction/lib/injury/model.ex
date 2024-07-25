defmodule Injury.Model do
    @moduledoc false
  def load_data(file_path) do
    file_path
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.drop(1)
    |> Enum.map(&parse_row/1)
  end

  defp parse_row(row) do
    columns = String.split(row, ",")
    %{
      player_key: Enum.at(columns, 0),
      days: String.to_integer(Enum.at(columns, 9)),
      part: Enum.at(columns, 3),
      player_name: Enum.at(columns, 2)
    }
  end



  def save_predictions(predictions, file_path) do
    File.write!(file_path, "player_key, playername,ruled_out\n" <> Enum.map_join(predictions, "\n", fn %{player_key: player_key, player_name: player_name, prediction: prediction} -> "#{player_key}, #{player_name}, #{prediction}" end))
  end
end
