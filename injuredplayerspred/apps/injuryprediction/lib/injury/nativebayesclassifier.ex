defmodule Injury.NaiveBayesClassifier do
  defstruct counts: %{}, total_count: 0
  @moduledoc false
  def categorize_days(days) do
    cond do
      days <= 7 -> "1"
      days <= 28 -> "2"
      days <= 42 -> "3"
      true -> "4"
    end
  end

  def train(data) do
    data
    |> Enum.reduce(%Injury.NaiveBayesClassifier{}, fn entry, model ->
      days_category = Injury.NaiveBayesClassifier.categorize_days(entry.days)
      update_model(model, days_category, entry.part)
    end)
  end

  def calculate_probabilities(%Injury.NaiveBayesClassifier{
        counts: counts,
        total_count: total_count
      }) do
    {days_category_counts, part_counts} =
      Enum.split_with(counts, fn {{category, _}, _} -> category == :days_category end)

    days_category_probabilities =
      Enum.reduce(days_category_counts, %{}, fn {{_, value}, count}, acc ->
        probability = count / total_count
        Map.put(acc, value, probability)
      end)

    part_probabilities =
      Enum.reduce(part_counts, %{}, fn {{_, value}, count}, acc ->
        probability = count / total_count
        Map.put(acc, value, probability)
      end)

    %{
      days_category_probabilities: days_category_probabilities,
      part_probabilities: part_probabilities
    }
  end

  def get_total_count(%Injury.NaiveBayesClassifier{total_count: total_count}) do
    total_count
  end

  defp update_model(
         %Injury.NaiveBayesClassifier{counts: counts, total_count: total_count} = model,
         days_category,
         part
       ) do
    new_counts =
      counts
      |> update_count({:days_category, days_category}, 1)
      |> update_count({:part, part}, 1)

    %Injury.NaiveBayesClassifier{model | counts: new_counts, total_count: total_count + 1}
  end

  defp update_count(counts, key, value) do
    Map.update(counts, key, value, &(&1 + value))
  end

  def average(model, days, part) do
    days_category = Injury.NaiveBayesClassifier.categorize_days(days)
    days_prob = Map.get(model.days_category_probabilities, days_category)
    part_prob = Map.get(model.part_probabilities, part)
    days_prob * part_prob
  end

  def predict(model, days, part, avg) do
    days_category = Injury.NaiveBayesClassifier.categorize_days(days)
    days_prob = Map.get(model.days_category_probabilities, days_category)
    part_prob = Map.get(model.part_probabilities, part)
    ruledoout = days_prob * part_prob
    if ruledoout > avg, do: to_string("Yes"), else: to_string("No")
  end
end
