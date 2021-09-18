defmodule SimdSample do
  require Logger

  @moduledoc """
  Documentation for SimdSample.
  """
  @on_load :load_nif

  def load_nif do
    nif_file = '#{Application.app_dir(:simd_sample, "priv/lib/libnif")}'

    case :erlang.load_nif(nif_file, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.error("Failed to load NIF: #{inspect(reason)}")
    end
  end

  def sketch(), do: sketch(:ok)

  def sketch(_value), do: raise("NIF sketch/1 not implemented")

  @doc """
  Hello world.

  ## Examples

      iex> SimdSample.hello
      :world

  """
  def hello do
    :world
  end
end
