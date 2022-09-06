defmodule PlugStaticExample do

  plug Plug.Static, at: "/", from: :server

  def run(args) do
    IO.puts("running PlugStaticExample!")
  end

end
