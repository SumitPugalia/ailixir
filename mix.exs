defmodule Ailixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :ailixir,
      version: "0.1.0",
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      compilers: [:phoenix_live_view] ++ Mix.compilers(),
      listeners: [Phoenix.CodeReloader]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Ailixir.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  def cli do
    [
      preferred_envs: [precommit: :test]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix framework
      {:phoenix, "~> 1.8.0"},
      {:phoenix_ecto, "~> 4.5"},
      {:ecto_sql, "~> 3.12"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.1.0"},
      {:lazy_html, ">= 0.1.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:esbuild, "~> 0.10", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.3", runtime: Mix.env() == :dev},
      {:heroicons,
       github: "tailwindlabs/heroicons",
       tag: "v2.2.0",
       sparse: "optimized",
       app: false,
       compile: false,
       depth: 1},
      {:swoosh, "~> 1.16"},
      {:req, "~> 0.5"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.1"},
      {:gettext, "~> 0.26"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.3 or ~> 0.2.0"},
      {:bandit, "~> 1.5"},
      # Override castore to resolve dependency conflicts
      {:castore, "~> 1.0", override: true},
      # Machine Learning / AI libraries
      # Core numerical computing (NumPy equivalent)
      {:nx, "~> 0.10"},
      # Deep Learning / Neural Networks (TensorFlow/PyTorch equivalent)
      {:axon, "~> 0.5"},
      # Pretrained transformer models (Transformers equivalent)
      {:bumblebee, "~> 0.1"},
      # Traditional Machine Learning (SKLearn equivalent)
      {:scholar, "~> 0.2"},
      # Tabular dataframe manipulation (Pandas equivalent)
      {:explorer, "~> 0.5"},
      # Gradient-Boosted Decision Trees (XGBoost equivalent)
      {:exgboost, "~> 0.1"},
      # Sample datasets (SKLearn Datasets equivalent)
      {:scidata, "~> 0.1"},
      # LangChain framework for LLM applications
      {:langchain, "~> 0.4"},
      # Data visualization (Matplotlib equivalent)
      {:vega_lite, "~> 0.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["compile", "tailwind ailixir", "esbuild ailixir"],
      "assets.deploy": [
        "tailwind ailixir --minify",
        "esbuild ailixir --minify",
        "phx.digest"
      ],
      precommit: ["compile --warning-as-errors", "deps.unlock --unused", "format", "test"]
    ]
  end
end
