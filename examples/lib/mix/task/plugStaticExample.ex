defmodule PlugStaticExample do

  plug Plug.Static, at: "/", from: :server
  plug Plug.Session, store: :ets, key: "_my_app_session", table: :session

  def run(args) do
    IO.puts("running PlugStaticExample!")
  end

end
