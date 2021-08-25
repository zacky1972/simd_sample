defmodule SimdSampleTest do
  use ExUnit.Case
  doctest SimdSample

  test "greets the world" do
    assert SimdSample.hello() == :world
  end
end
