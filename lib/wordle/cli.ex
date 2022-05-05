defmodule Wordle.Cli do
  def show(game) do
    Enum.each(game.guesses, &print_guess/1)
  end

  defp print_guess(guess) do
    guess.tally
    |> Enum.map(fn {letter, state} ->
      case state do
        :correct -> IO.ANSI.format([:green, letter])
        :incorrect -> IO.ANSI.format([:red, letter])
        :in_word -> IO.ANSI.format([:yellow, letter])
      end
    end)
    |> IO.puts
  end
end
