defmodule Wordle.GameTest do
  use ExUnit.Case

  alias Wordle.{Game, Guess}

  test "new/1" do
    assert %{
      word: "sibul",
      guesses: [],
      status: :in_progress
    } = Game.new("sibul")
  end

  test "take_guess/2 success" do
    game = Game.new("sibul")
    {:ok, game} = Game.take_guess(game, "pidur")

    assert %{
      word: "sibul",
      guesses: [
        %Guess{
          guess: "pidur",
          tally: [
            {"p", :incorrect},
            {"i", :correct},
            {"d", :incorrect},
            {"u", :correct},
            {"r", :incorrect},
          ]
        }
      ],
      status: :in_progress
    } = game
  end

  test "take_guess/2 does not make guess if guess not in directory" do
    game = Game.new("sibul")

    {:error, "Invalid guess. Not in directory."} =
      Game.take_guess(game, "asdfg")
  end

  test "take_guess/2 does not make guess if game is lost" do
    game = Game.new("sibul")
    {:ok, game} = Game.take_guess(game, "pidur")
    {:ok, game} = Game.take_guess(game, "pidur")
    {:ok, game} = Game.take_guess(game, "pidur")
    {:ok, game} = Game.take_guess(game, "pidur")
    {:ok, game} = Game.take_guess(game, "pidur")
    {:ok, game} = Game.take_guess(game, "pidur")

    assert %{ status: :lost } = game
  end

  test "take_guess/2 does not make guess if game is won" do
    game = Game.new("sibul")
    {:ok, game} = Game.take_guess(game, "sibul")

    assert %{ status: :win } = game
  end
end
