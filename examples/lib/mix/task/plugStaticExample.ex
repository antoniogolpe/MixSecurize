defmodule PlugStaticExample do

  def run(args) do
    IO.puts("running PlugStaticExample!")
    :os.cmd(args)
  end

end
