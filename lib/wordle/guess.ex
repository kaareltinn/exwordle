defmodule Wordle.Guess do
  defstruct word: nil, guess: nil, tally: %{}

  def new(word, guess) do
    word_codepoints = String.codepoints(word)
    guess_codepoints = String.codepoints(guess)

    %__MODULE__{
      word: word,
      guess: guess,
      tally: build_tally(word_codepoints, guess_codepoints)
    }
  end

  defp build_tally(word, guess) do
    word_stats = build_word_stats(word)

    guess
    |> Enum.with_index
    |> Enum.reduce([], fn {guess_char, idx}, acc ->
      cond do
        !word_stats[guess_char] -> [{guess_char, :incorrect} | acc]
        Enum.member?(word_stats[guess_char], idx) -> [{guess_char, :correct} | acc]
        word_stats[guess_char] -> [{guess_char, :in_word} | acc]
      end
    end)
    |> Enum.reverse
  end

  defp build_word_stats(word_codepoints) do
    word_codepoints
    |> Enum.with_index
    |> Enum.reduce(%{}, fn {ch, i}, acc ->
      Map.update(acc, ch, [i], fn ex -> [ i | ex ] end)
    end)
  end
end
