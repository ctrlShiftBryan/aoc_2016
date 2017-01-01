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

  # Server (callbacks)
  def handle_call({:read}, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:calc, {direction, distance}}, _from, {facing, x, y, history})do

    current_location = {x, y}

    {facing, x, y} = facing
                     |> transition(direction)
                     |> move(distance, current_location)

    new_state = {facing, x, y, history}

    {:reply, new_state, new_state}
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
