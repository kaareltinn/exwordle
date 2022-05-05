defmodule Wordle.Game do
  alias Wordle.Guess

  def new(word) do
    %{
      word: word,
      guesses: [],
      status: :in_progress,
    }
  end

  def take_guess(game, guess) do
    with :ok <- check_guess(guess),
         :ok <- check_status(game)
    do
      {:ok, game |> make_guess(guess) |> check_win(Guess.new(game.word, guess))}
    else
      err -> err
    end
  end

  defp check_guess(guess) do
    if Enum.member?(Wordle.Dictionary.words, guess) do
      :ok
    else
      {:error, "Invalid guess. Not in directory."}
    end
  end

  defp check_status(game) do
    case game.status do
      :win -> {:game_over, :win}
      :lost -> {:game_over, :lost}
      :in_progress -> :ok
    end
  end

  defp check_win(game, guess) do
    cond do
      Enum.all?(guess.tally, fn {_, state} -> state == :correct end) -> %{game | status: :win}
      Enum.count(game.guesses) >= 6 -> %{game | status: :lost}
      true -> game
    end
  end

  defp make_guess(game, guess) do
    Map.put(
      game,
      :guesses,
      List.insert_at(game.guesses, -1, Guess.new(game.word, guess))
    )
  end
end
