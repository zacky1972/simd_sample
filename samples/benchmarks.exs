Benchee.run(
  %{
    "aos0" => fn -> SimdSample.aos0_test() end,
    "soa0" => fn -> SimdSample.soa0_test() end
  }
)
