defmodule GBK.MixProject do
  use Mix.Project
  @description """
  gbk to utf8
  """

  def project do
    [
      app: :exgbk,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: @description,
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:httpoison, "~> 1.2.0", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["guidao"],
      licenses: ["MIT"],
      links: %{
        GitHub: "https://github.com/guidao/exgbk"
      }
    ]
  end
end
