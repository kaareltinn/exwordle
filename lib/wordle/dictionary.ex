defmodule Wordle.Dictionary do
  @words  "lib/data/words.csv"
          |> File.read!
          |> String.split("\r\n")
          |> Enum.map(&String.split(&1, ";"))
          |> Enum.map(&hd/1)
          |> Enum.map(&String.downcase/1)
          |> Enum.filter(fn w -> String.length(w) == 5 end)

  def random_word do
    @words |> Enum.random
  end

  def words do
    @words
  end
end
