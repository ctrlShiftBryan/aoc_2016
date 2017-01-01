defmodule Aoc2016.Day1 do

  def calc(input) do
    {:ok, pid} = Aoc2016.Day1GenServer.start_link()
    for n <- parse(input), do: Aoc2016.Day1GenServer.calc(pid, n)
    { _, x ,y, _} = Aoc2016.Day1GenServer.get(pid)
    Kernel.abs(x) + Kernel.abs(y)
  end

  def parse(input) do
    input
    |> String.split(", ")
    |> dir_split
  end

  defp dir_split(["R" <> distance | tail]), do: [{:right, distance |> do_parse}] ++ dir_split(tail)
  defp dir_split(["L" <> distance | tail]), do: [{:left, distance |> do_parse}] ++ dir_split(tail)
  defp dir_split([]), do: []

  defp do_parse(distance) do
    with {whole, remainder} <- distance |> Integer.parse do
      whole
    else
      :error -> {:error, "Error parsing input"}
    end
  end

end
