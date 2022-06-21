defmodule Securize do
  defmodule Checker do
    @type issue :: %{
      message: String.t,
      line: integer,
      columns: integer
    }

    @callback run(ast :: any) :: [issue]
  end

  @checkers [UnsafeToAtomCheck,MultiAliasCheck,Cmd,ObserverStart]

  def fileToQuoted(file) do
    ast =
      file
      |> Path.expand()
      |> File.read!()
      |> Code.string_to_quoted(columns: true)

    #IO.inspect(ast)

    issues =
      Enum.map(@checkers, fn checker -> checker.run(ast) end)
      |> List.flatten()

    Enum.each(issues, fn issue -> print_issue(file, issue) end)

    :ok
  end

  defp print_issue(file, issue) do
    [
    :reset, :yellow,
    issue.message, "\n",
    :faint,
    "#{file}:#{issue.line}:#{issue.column}\n",
    :reset
    ]
    |> IO.ANSI.format()
    |> IO.puts
  end

  def securize(args) do
    Enum.map(args, fn x -> fileToQuoted(x) end)
  end

end
