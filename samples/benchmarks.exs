{:ok, result} = SimdSample.aos0_test()
{:ok, ^result} = SimdSample.soa0_test()
{:ok, ^result} = SimdSample.soa1_test()
{:ok, ^result} = SimdSample.soa1_16_test()
^result = SimdSample.nx_aos32_test()
^result = SimdSample.nx_aos16_test()

Benchee.run(
  %{
    "aos0" => fn -> SimdSample.aos0_test() end,
    "soa0" => fn -> SimdSample.soa0_test() end,
    "soa1" => fn -> SimdSample.soa1_test() end,
    "soa1_16" => fn -> SimdSample.soa1_16_test() end,
    "nx_aos32" => fn -> SimdSample.nx_aos32_test() end,
    "nx_aos16" => fn -> SimdSample.nx_aos16_test() end
  }
) \
|> then(fn _ -> :ok end)
