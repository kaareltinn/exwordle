defmodule Wordle.GuessTest do
  use ExUnit.Case

  alias Wordle.Guess

  test "new/1 returns all correct" do
    assert %Guess{
      word: "pidur",
      guess: "pidur",
      tally: [
        {"p", :correct},
        {"i", :correct},
        {"d", :correct},
        {"u", :correct},
        {"r", :correct},
      ]
    } = Guess.new("pidur", "pidur")
  end

  test "new/1 returns some correct, some incorrect" do
    assert %Guess{
      word: "sibul",
      guess: "pidur",
      tally: [
        {"p", :incorrect},
        {"i", :correct},
        {"d", :incorrect},
        {"u", :correct},
        {"r", :incorrect},
      ]
    } = Guess.new("sibul", "pidur")
  end

  test "word: klots, guess: kalur" do
    assert %Guess{
      word: "klots",
      guess: "kalur",
      tally: [
        {"k", :correct},
        {"a", :incorrect},
        {"l", :in_word},
        {"u", :incorrect},
        {"r", :incorrect},
      ]
    } = Guess.new("klots", "kalur")
  end

  test "new/1 returns some incorrect, some in word" do
    assert %Guess{
      word: "kiivi",
      guess: "ilves",
      tally: [
        {"i", :in_word},
        {"l", :incorrect},
        {"v", :in_word},
        {"e", :incorrect},
        {"s", :incorrect},
      ]
    } = Guess.new("kiivi", "ilves")
  end

  test "new/1 returns some correct, some incorrect, some in word" do
    assert %Guess{
      word: "kiivi",
      guess: "iiris",
      tally: [
        {"i", :in_word},
        {"i", :correct},
        {"r", :incorrect},
        {"i", :in_word},
        {"s", :incorrect},
      ]
    } = Guess.new("kiivi", "iiris")
  end

  test "new/1 does not count letter correct twice ('a' in that case)" do
    assert %Guess{
      word: "vagur",
      guess: "vasar",
      tally: [
        {"v", :correct},
        {"a", :correct},
        {"s", :incorrect},
        {"a", :incorrect},
        {"r", :correct},
      ]
    } = Guess.new("vagur", "vasar")
  end
end
