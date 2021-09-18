defmodule SimdSample.Sin do
  require Logger

  @moduledoc """
  Documentation for SimdSample.Sin.
  """

  @on_load :load_nif

  def load_nif do
    nif_file = '#{Application.app_dir(:simd_sample, "priv/lib/libsin")}'

    case :erlang.load_nif(nif_file, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.error("Failed to load NIF: #{inspect(reason)}")
    end
  end

  def sin(x) when is_struct(x, Nx.Tensor) do
    sin_nif(x)
  end
  def sin(x) when is_number(x) do
    sin_nif(Nx.tensor(x))
  end

  def sin_nif(_x), do: raise("NIF sin_nif/1 not implemented")

end
