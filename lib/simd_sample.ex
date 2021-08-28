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
  @spec transpose_vector(Nx.t()) :: Nx.t()
  def transpose_vector(vector) do
    Nx.reshape(vector, {Nx.size(vector), 1})
  end

  @spec broadcast_vector(Nx.t(), Nx.t()) :: Nx.t()
  def broadcast_vector(vector, shape) do
    Nx.broadcast(transpose_vector(vector), shape)
  end

  @spec monochrome_filter_aos_32(Nx.Tensor.t()) :: Nx.t()
  def monochrome_filter_aos_32(pixel) do
    {_, 3} = Nx.shape(pixel)

    mono = Nx.tensor([0.299, 0.587, 0.114], type: {:f, 32})

    pixel_m = Nx.dot(pixel, mono)

    broadcast_vector(pixel_m, pixel)
    |> Nx.round()
    |> Nx.as_type({:u, 8})
  end

  @spec monochrome_filter_aos_16(Nx.Tensor.t()) :: Nx.t()
  def monochrome_filter_aos_16(pixel) do
    {_, 3} = Nx.shape(pixel)

    mono = Nx.tensor([0.299, 0.587, 0.114], type: {:f, 16})

    pixel_m = Nx.dot(pixel, mono)

    broadcast_vector(pixel_m, pixel)
    |> Nx.round()
    |> Nx.as_type({:u, 8})
  end

  @spec init_pixel() :: Nx.t()
  def init_pixel() do
    Nx.tensor([0x9f, 0x5a, 0xae], type: {:u, 8})
    |> broadcast_vector({3, 256})
    |> Nx.transpose()
  end

  def nx_aos32_test() do
    ip = init_pixel()

    1..1000
    |> Enum.reduce(fn _, _ -> monochrome_filter_aos_32(ip) end)
    |> Nx.sum()
    |> Nx.to_scalar()
  end

  def nx_aos16_test() do
    ip = init_pixel()

    1..1000
    |> Enum.reduce(fn _, _ -> monochrome_filter_aos_16(ip) end)
    |> Nx.sum()
    |> Nx.to_scalar()
  end

  def aos0_test(), do: raise("NIF aos0_test/0 not implemented")

  def soa0_test(), do: raise("NIF soa0_test/0 not implemented")

  def soa1_test(), do: raise("NIF soa1_test/0 not implemented")

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
