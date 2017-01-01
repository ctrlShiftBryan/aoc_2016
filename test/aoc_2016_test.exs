defmodule Aoc2016Test do
  use ExUnit.Case
  doctest Aoc2016

  test "the truth" do
    assert Aoc2016.Day1.calc([r: 2, l: 3]) == 5

    assert Aoc2016.Day1.calc([r: 2, r: 2, r: 2]) == 2

    assert Aoc2016.Day1.calc([r: 5, l: 5, r: 5, r: 3]) == 12
  end
end
