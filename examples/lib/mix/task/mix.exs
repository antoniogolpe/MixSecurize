defmodule Plug.MixProject do
  use Mix.Project

  def deps do
    [
      {:mime, "~> 1.0 or ~> 2.0"},
      {:plug, "~> 1.1.0"},
      {:paginator, "~> 0.1.0"},
      {:telemetry, "~> 0.4.3 or ~> 1.0"},
      {:ex_doc, "~> 0.21", only: :docs}
    ]
  end

end
