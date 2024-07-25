defmodule Injury.NaivebayesclassifierTest do
  @moduledoc """
  Testing classifier
  """

  use ExUnit.Case

  test "bayes check" do
    input = Path.join(:code.priv_dir(:injuryprediction), "injury.csv")
    assert %Injury.NaiveBayesClassifier{} = %Injury.NaiveBayesClassifier{counts: nil, total_count: nil}
    data = Injury.Model.load_data(input)
    Injury.NaiveBayesClassifier.train(data)

  end
end
