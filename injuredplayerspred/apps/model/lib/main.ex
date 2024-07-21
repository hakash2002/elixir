defmodule Main do
  def run(file_path, output_path) do
    data = Model.load_data(file_path)
    model = NaiveBayesClassifier.train(data)

    mod = NaiveBayesClassifier.calculate_probabilities(model)

    s =
      Enum.sum(
        Enum.map(data, fn entry ->
          NaiveBayesClassifier.average(mod, entry.days, entry.part)
        end)
      )

    tot = NaiveBayesClassifier.get_total_count(model)
    IO.inspect(tot)

    predictions =
      Enum.map(data, fn entry ->
        prediction = NaiveBayesClassifier.predict(mod, entry.days, entry.part, s / tot)

        %{
          player_key: entry.player_key,
          player_name: entry.player_name,
          prediction: prediction
        }
      end)

    Model.save_predictions(predictions, output_path)
    l = "wrtitten to the file#{output_path}"
    l
  end
end

# Run the script
