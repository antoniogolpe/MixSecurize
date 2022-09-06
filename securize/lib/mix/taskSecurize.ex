defmodule Mix.Tasks.Securize do
  use Mix.Task

  @shortdoc "Simply calls the Securize.securize/1 function."
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")

    if File.dir?(args) do
      #Securize.securize( Path.wildcard(Enum.join([args, "/**/*.ex"], "")))
      Securize.securize( Path.wildcard(Enum.join([args, "/**/*.ex"], "")),Path.wildcard(Enum.join([args, "/**/*.exs"], "")))
    else
      "No se encontro el directorio"|> IO.puts
    end
  end
end
