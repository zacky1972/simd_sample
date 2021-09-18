
input_f32 = Nx.iota({256}, type: {:f, 32})
input_f16 = Nx.iota({256}, type: {:f, 16})

Benchee.run(
  %{
    "nx_aos32" => fn -> Nx.sin(input_f32) end,
    "nx_aos16" => fn -> Nx.sin(input_f16) end
  }
) \
|> then(fn _ -> :ok end)
