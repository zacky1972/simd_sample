defmodule SimdSample.MixProject do
  use Mix.Project

  @app :simd_sample
  @version "1.7.1"
  @all_targets [:rpi, :rpi0, :rpi2, :rpi3, :rpi3a, :rpi4, :bbb, :osd32mp1, :x86_64]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.9",
      archives: [nerves_bootstrap: "~> 1.10"],
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host],
      compilers: [:elixir_make] ++ Mix.compilers(),
      aliases: [
        compile: [&autoreconf/1, &configure/1, "clean", &install/1, "compile"],
        clean: [&autoreconf/1, &configure/1, "clean"]
      ],
      make_clean: ["clean"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {SimdSample.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Dependencies for all targets
      {:nerves, "~> 1.7.0", runtime: false},
      {:shoehorn, "~> 0.7.0"},
      {:ring_logger, "~> 0.8.1"},
      {:toolshed, "~> 0.2.13"},
      {:elixir_make, "~> 0.6.2", runtime: false},
      {:benchee, "~> 1.0", only: :dev},
      {:nx, "~> 0.1.0-dev", github: "elixir-nx/nx", branch: "main", sparse: "nx"},

      # Dependencies for all targets except :host
      {:nerves_runtime, "~> 0.11.3", targets: @all_targets},
      {:nerves_pack, "~> 0.4.0", targets: @all_targets},

      # Dependencies for specific targets
      {:nerves_system_rpi, "~> 1.13", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.13", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.13", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.13", runtime: false, targets: :rpi3},
      {:nerves_system_rpi3a, "~> 1.13", runtime: false, targets: :rpi3a},
      {:nerves_system_rpi4, "~> 1.13", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.8", runtime: false, targets: :bbb},
      {:nerves_system_osd32mp1, "~> 0.4", runtime: false, targets: :osd32mp1},
      {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64}
    ]
  end

  def release do
    [
      overwrite: true,
      # Erlang distribution is not started automatically.
      # See https://hexdocs.pm/nerves_pack/readme.html#erlang-distribution
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: Mix.env() == :prod or [keep: ["Docs"]]
    ]
  end

  defp autoreconf(_args) do
    System.cmd("autoreconf", ["-i"])
  end

  defp configure(_args) do
    host = System.get_env("REBAR_TARGET_ARCH")
    if is_nil(host) do
      System.cmd(
        "#{File.cwd!()}/configure",
        ["--prefix=#{Mix.Project.app_path()}/priv"]
      )
    else
      System.cmd(
        "#{File.cwd!()}/configure",
        ["--prefix=#{Mix.Project.app_path()}/priv", "--host=#{host}"]
      )
    end
  end

  defp install(_args) do
    System.cmd("make", ["install"])
  end
end
