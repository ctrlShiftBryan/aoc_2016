defmodule Aoc2016.Day1GenServer do
  use GenServer

  def start_link() do
    # initial state facing north at 0, 0
    GenServer.start_link(__MODULE__, {:north, 0,0, %{}})
  end

  def calc(pid, move) do
    GenServer.call(pid, {:calc, move})
  end

  def get(pid) do
    GenServer.call(pid, {:read})
  end

  def get_history(pid) do
    GenServer.call(pid, {:read_history})
  end

  # Server (callbacks)
  def handle_call({:read}, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:read_history}, _from, {facing, x, y, history} = state) do
    with {:ok, x, y} <- history[:found_it] do
      {:reply, {x, y}, state}
    else
      nil -> {:reply, :notfound, state}
    end
  end

  def handle_call({:calc, {direction, distance}}, _from, {facing, x, y, history})do

    current_location = {x, y}

    {facing, x, y} = facing
                     |> transition(direction)
                     |> move(distance, current_location)

    new_history = update_history(history, {x, y})

    new_state = {facing, x, y, new_history}

    {:reply, new_state, new_state}
  end

  def update_history(history, {x, y}) do
    IO.inspect {history, x, y}
    with nil <- history[:found_it],
         nil <- history[{x, y}]
    do
      # add it for the first time
      history |> Map.merge(%{{x, y} => 1})
    else
      # stop tracking we already found it
      {:hq, x, y} ->  history
      # not nil so already in map once, found it
      _ -> history |> Map.merge(%{:found_it => {:hq, x, y}})
    end
  end

  defp move(:north, m, {x , y}), do: {:north, x + m, y}
  defp move(:south, m, {x , y}), do: {:south, x - m, y}
  defp move(:east, m, {x , y}), do: {:east, x, y + m}
  defp move(:west, m, {x , y}), do: {:west, x, y - m}

  defp transition(:north, :left), do: :west
  defp transition(:north, :right), do: :east
  defp transition(:east, :left), do: :north
  defp transition(:east, :right), do: :south
  defp transition(:south, :left), do: :east
  defp transition(:south, :right), do: :west
  defp transition(:west, :left), do: :south
  defp transition(:west, :right), do: :north
end
