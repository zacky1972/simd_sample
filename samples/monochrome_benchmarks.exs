{:ok, result} = SimdSample.MonochromeFilter.aos0_test()
{:ok, ^result} = SimdSample.MonochromeFilter.soa0_test()
{:ok, ^result} = SimdSample.MonochromeFilter.soa1_test()
^result = SimdSample.MonochromeFilter.nx_aos32_test()
^result = SimdSample.MonochromeFilter.nx_aos16_test()

Benchee.run(
  %{
    "aos0" => fn -> SimdSample.MonochromeFilter.aos0_test() end,
    "soa0" => fn -> SimdSample.MonochromeFilter.soa0_test() end,
    "soa1" => fn -> SimdSample.MonochromeFilter.soa1_test() end,
    "nx_aos32" => fn -> SimdSample.MonochromeFilter.nx_aos32_test() end,
    "nx_aos16" => fn -> SimdSample.MonochromeFilter.nx_aos16_test() end
  }
) \
|> then(fn _ -> :ok end)
