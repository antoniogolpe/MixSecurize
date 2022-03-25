defmodule Hello do
  @doc """
  Outputs `Hello, World!` every time.
  """
  def say do
    IO.puts("Hello, World!")
  end

  def say(args) do
    IO.puts("running!")
    Mix.shell().info(Enum.join(args, " "))
    IO.inspect(args, label: "Received args")
  end

end
