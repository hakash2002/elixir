defmodule Injury.Main do
  @moduledoc false
  def run(file_path, output_path) do
    data = Injury.Model.load_data(file_path)
    model = Injury.NaiveBayesClassifier.train(data)
    mod = Injury.NaiveBayesClassifier.calculate_probabilities(model)

    s =
      Enum.sum(
        Enum.map(data, fn entry ->
          Injury.NaiveBayesClassifier.average(mod, entry.days, entry.part)
        end)
      )

    tot = Injury.NaiveBayesClassifier.get_total_count(model)

    predictions =
      Enum.map(data, fn entry ->
        prediction = Injury.NaiveBayesClassifier.predict(mod, entry.days, entry.part, s / tot)

        %{
          player_key: entry.player_key,
          player_name: entry.player_name,
          prediction: prediction
        }
      end)

    Injury.Model.save_predictions(predictions, output_path)
    "written to the file#{output_path}"
  end
end
