defmodule UdpClientServer.Mixfile do
  use Mix.Project
  use Mix.Task

  def project do
    [
      app: :udp_client_server,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:socket, "~> 0.3"},
      {:mint, "~> 1.0"},
      {:httpoison, "~> 1.6"}
    ]
  end

  defp aliases do
    [
      all: ["compile", &run/1]
    ]
  end

  def run(_) do
    UdpClientServer.launch_server()
  end
end
