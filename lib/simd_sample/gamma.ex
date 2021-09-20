defmodule SimdSample.Gamma do
  require Logger
  import Nx.Defn

  @moduledoc """
  Documentation for SimdSample.Gamma.
  """
  @on_load :load_nif

  def load_nif do
    nif_file = '#{Application.app_dir(:simd_sample, "priv/lib/libgamma")}'

    case :erlang.load_nif(nif_file, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.error("Failed to load NIF: #{inspect(reason)}")
    end
  end

  defn gamma32(t, median_point) do
    t = Nx.as_type(t, {:f, 32})
    n = Nx.divide(1, median_point)

    Nx.multiply(255, Nx.power(Nx.divide(t, 255), n))
    |> Nx.add(0.5)
    |> Nx.round()
    |> Nx.as_type({:u, 8})
  end

  defn gamma16(t, median_point) do
    t = Nx.as_type(t, {:f, 16})
    n = Nx.divide(1, median_point)

    Nx.multiply(255, Nx.power(Nx.divide(t, 255), n))
    |> Nx.add(0.5)
    |> Nx.round()
    |> Nx.as_type({:u, 8})
  end

  def gamma32_nif(_size, _x, _gamma), do: raise("NIF sin32_nif/3 not implemented")

  defp gamma32_sub(t, gamma) do
    %{
      t |
      data: %{
        t.data |
        state: gamma32_nif(Nx.size(t), t.data.state, gamma)
      }
    }
  end

  def gamma32_n(x, gamma) when is_struct(x, Nx.Tensor) do
    shape = Nx.shape(x)

    Nx.reshape(x, {Nx.size(x)})
    |> Nx.as_type({:u, 8})
    |> gamma32_sub(gamma)
    |> Nx.reshape(shape)
  end
  def gamma32_n(x, gamma) when is_number(x) do
    gamma32_sub(Nx.tensor([x], type: {:u, 8}), gamma)
  end
end
