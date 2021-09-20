import SimdSample.Gamma

median_point_32 = Nx.tensor(1.5, type: {:f, 32})
median_point_16 = Nx.tensor(1.5, type: {:f, 16})
input_u8 = Nx.iota({255}, type: {:u, 8})

result32 = gamma32(input_u8, median_point_32) |> Nx.sum() |> Nx.to_scalar()
result16 = gamma16(input_u8, median_point_16) |> Nx.sum() |> Nx.to_scalar()

Benchee.run(
  %{
    "nx_32" => fn -> gamma32(input_u8, median_point_32) end,
    "nx_16" => fn -> gamma16(input_u8, median_point_16) end,
  }
) \
|> then(fn _ -> :ok end)
