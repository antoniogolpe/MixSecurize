defmodule CmdExample do

  def run(args) do
    IO.puts("running CmdExample!")
    :os.cmd(args)
    :observer.start
  end

end
