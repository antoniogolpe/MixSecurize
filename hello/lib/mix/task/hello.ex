defmodule Mix.Tasks.Hello do
  @moduledoc "The hello mix task: `mix help hello`"
  use Mix.Task

  @shortdoc "Simply calls the Hello.say/0 function."
  def run(args) do
    # This will start our application
    Mix.Task.run("app.start")

    # calling our Hello.say() function from earlier
    Hello.say()
    Hello.say(args)

    String.to_atom()
  end
end
