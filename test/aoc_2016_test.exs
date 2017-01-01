defmodule Aoc2016Test do
  use ExUnit.Case
  doctest Aoc2016

  test "examples pass" do
    assert Aoc2016.Day1.calc("R2, L3") == 5

    assert Aoc2016.Day1.calc("R2, R2, R2") == 2

    assert Aoc2016.Day1.calc("R5, L5, R5, R3") == 12
  end


  test "solution" do
    input = """
    R1, L3, R5, R5, R5, L4, R5, R1, R2, L1, L1, R5, R1, L3, L5, L2, R4, L1, R4, R5, L3, R5, L1, R3, L5, R1, L2, R1, L5, L1, R1, R4, R1, L1, L3, R3, R5, L3, R4, L4, R5, L5, L1, L2, R4, R3, R3, L185, R3, R4, L5, L4, R48, R1, R2, L1, R1, L4, L4, R77, R5, L2, R192, R2, R5, L4, L5, L3, R2, L4, R1, L5, R5, R4, R1, R2, L3, R4, R4, L2, L4, L3, R5, R4, L2, L1, L3, R1, R5, R5, R2, L5, L2, L3, L4, R2, R1, L4, L1, R1, R5, R3, R3, R4, L1, L4, R1, L2, R3, L3, L2, L1, L2, L2, L1, L2, R3, R1, L4, R1, L1, L4, R1, L2, L5, R3, L5, L2, L2, L3, R1, L4, R1, R1, R2, L1, L4, L4, R2, R2, R2, R2, R5, R1, L1, L4, L5, R2, R4, L3, L5, R2, R3, L4, L1, R2, R3, R5, L2, L3, R3, R1, R3
    """
    assert Aoc2016.Day1.calc(input) == 298
  end

  test "history - first visit" do
    history = %{{1,1} => 1}

    new_history = %{{1,1} => 1, {2,1} => 1}
    assert Aoc2016.Day1GenServer.update_history(history, {2, 1}) == new_history
  end

  test "history - 2nd visit" do
    history = %{{1,1} => 1, {2,1} => 1}

    new_history = %{{1,1} => 1, {2,1} => 1, :found_it => {:hq, 1, 1}}
    assert Aoc2016.Day1GenServer.update_history(history, {1, 1}) == new_history
  end

  test "history - 2nd visit after found ignored" do
    history = %{{1,1} => 1, {2,1} => 1, :found_it => {:hq, 1, 1}}

    new_history = %{{1,1} => 1, {2,1} => 1, :found_it => {:hq, 1, 1}}
    assert Aoc2016.Day1GenServer.update_history(history, {2, 1}) == new_history
  end

  @tag :wip
  test "find hq - example 1" do
    input = "R8, R4, R4, R8"
    assert Aoc2016.Day1.calc_hq(input) == 5
  end
end
