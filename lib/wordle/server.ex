defmodule Wordle.Server do
  use GenServer

  def start(word) do
    GenServer.start(__MODULE__, Wordle.Game.new(word))
  end

  def guess(server, guess) do
    GenServer.call(server, {:guess, guess})
  end

  def get_state(server) do
    GenServer.call(server, :get_state)
  end

  @impl GenServer
  def init(game) do
    {:ok, game}
  end

  @impl GenServer
  def handle_call({:guess, guess}, _, game) do
    with {:ok, new_game} <- Wordle.Game.take_guess(game, guess)
    do
      {:reply, guess, new_game}
    else
      {:error, reason} -> {:reply, reason, game}
    end
  end

  def handle_call(:get_state, _, game) do
    {:reply, game, game}
  end
end
