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

  def sin32_1(x) when is_struct(x, Nx.Tensor) do
    if Nx.type(x) == {:f, 32} do
      x
    else
      Nx.as_type(x, {:f, 32})
    end
    |> sin32_1_sub()
  end
  def sin32_1(x) when is_float(x) do
    sin32_1_sub(Nx.tensor([x]))
  end
  def sin32_1(x) when is_integer(x) do
    sin32_1_sub(Nx.tensor([x * 1.0]))
  end

  defp sin32_1_sub(t) do
    %{
      t |
      data: %{
        t.data |
        state: sin32_1_nif(Nx.size(t), t.data.state)
      }
    }
  end

  def sin32_1_nif(_size, _x), do: raise("NIF sin32_1_nif/2 not implemented")

  def sin32(x) when is_struct(x, Nx.Tensor) do
    shape = Nx.shape(x)

    Nx.reshape(x, {Nx.size(x)})
    |> Nx.as_type({:f, 32})
    |> sin32_nif()
    |> Nx.reshape(shape)
  end
  def sin32(x) when is_float(x) do
    sin32_nif(Nx.tensor([x]))
  end
  def sin32(x) when is_integer(x) do
    sin32_nif(Nx.tensor([x * 1.0]))
  end

  def sin32_nif(_x), do: raise("NIF sin32_nif/1 not implemented")

end
