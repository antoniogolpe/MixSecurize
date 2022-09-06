defmodule PlugSessionExample do



  plug Plug.Session, store: :ets, key: "_my_app_session", table: :session

  def run(args) do
    IO.puts("running PlugSessionExample!")
  end

end
