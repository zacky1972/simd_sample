
input_f32 = Nx.iota({0x1000000}, type: {:f, 32})
# input_f16 = Nx.iota({0x1000000}, type: {:f, 16})

result = Nx.sin(input_f32)
0.0 = Nx.subtract(result, SimdSample.Sin.sin32(input_f32)) |> Nx.sum() |> Nx.to_scalar()
0.0 = Nx.subtract(result , SimdSample.Sin.sin32_1(input_f32)) |> Nx.sum() |> Nx.to_scalar()

Benchee.run(
  %{
    "sin32_1" => fn -> SimdSample.Sin.sin32_1(input_f32) end,
    "sin32_0" => fn -> SimdSample.Sin.sin32(input_f32) end,
    "nx_32" => fn -> Nx.sin(input_f32) end,
#    "nx_16" => fn -> Nx.sin(input_f16) end
  }
) \
|> then(fn _ -> :ok end)
