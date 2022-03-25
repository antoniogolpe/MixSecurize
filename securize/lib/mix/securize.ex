defmodule Mix.Tasks.Securize do
  use Mix.Task

  @shortdoc "Simply calls the Hello.securize/1 function."
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")

    Securize.securize( Path.wildcard(args))
  end
end
