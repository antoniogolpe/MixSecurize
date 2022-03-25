defmodule SecurizeTest do
  use ExUnit.Case
  doctest Securize

  test "greets the world" do
    assert Securize.securize() == :world
  end
end
