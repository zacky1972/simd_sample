{:ok, result} = SimdSample.aos0_test()
{:ok, ^result} = SimdSample.soa0_test()
{:ok, ^result} = SimdSample.soa1_test()

Benchee.run(
  %{
    "aos0" => fn -> SimdSample.aos0_test() end,
    "soa0" => fn -> SimdSample.soa0_test() end,
    "soa1" => fn -> SimdSample.soa1_test() end
  }
)
