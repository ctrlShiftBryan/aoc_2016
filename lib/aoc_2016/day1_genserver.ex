defmodule Aoc2016.Day1GenServer do
  use GenServer

  def start_link() do
    # initial state facing north at 0, 0
    GenServer.start_link(__MODULE__, {:north, 0,0})
  end

  def calc(pid, move) do
    GenServer.call(pid, {:calc, move})
  end

  # Server (callbacks)

  def handle_call({:calc, {direction, distance}}, _from, {facing, x, y}) do

    new_state = facing |>  
                transition(direction) |> 
                move(distance, {x, y})

    {:reply, new_state, new_state}
  end

  defp move(:north, m, {x , y}), do: {:north, x, y + m}
  defp move(:south, m, {x , y}), do: {:south, x, y - m}
  defp move(:east, m, {x , y}), do: {:east, x + m, y}
  defp move(:west, m, {x , y}), do: {:west, x - m, y}

  defp transition(:north, :left), do: :west
  defp transition(:north, :right), do: :east
  defp transition(:east, :left), do: :north
  defp transition(:east, :right), do: :south
  defp transition(:south, :left), do: :east
  defp transition(:south, :right), do: :west
  defp transition(:west, :left), do: :south
  defp transition(:west, :right), do: :north
end
