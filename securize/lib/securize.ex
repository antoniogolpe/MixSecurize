defmodule Securize do
  defmodule Checker do
    @type issue :: %{
      message: String.t,
      line: integer,
      columns: integer
    }

    @callback run(ast :: any, deps:: any) :: [issue]
  end

  @checkers [UnsafeToAtomCheck,MultiAliasCheck,Cmd,CookieSecurity,PugCheck,PaginatorCheck]

  def fileToQuoted(file, deps) do
    ast =
      file
      |> Path.expand()
      |> File.read!()
      |> Code.string_to_quoted(columns: true)

    #IO.inspect(ast)

    issues =
      Enum.map(@checkers, fn checker -> checker.run(ast, deps) end)
      |> List.flatten()

    if(Enum.empty?(issues)) do
       "No se encontro ninguna vulnerabilidad"|> IO.puts
    else
      Enum.each(issues, fn issue -> print_issue(file, issue) end)
    end

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

  def securize(args, filesAuxs) do
    #deps = Enum.concat(Enum.map(filesAuxs, fn exs -> FindDeps.findDeps2(exs) end))
    #deps = Enum.map(filesAuxs, fn exs -> FindDeps.findDeps2(exs) end)
    listDeps = Enum.map(filesAuxs, fn exs -> FindDeps.findDeps2(exs) end)
    if(!Enum.empty?(listDeps)) do
      deps = Enum.reduce(listDeps, fn x, y ->
          Map.merge(x, y, fn _k, v1, v2 -> v2 ++ v1 end)end)
      Enum.map(args, fn x -> fileToQuoted(x,deps) end)
    else
      Enum.map(args, fn x -> fileToQuoted(x,%{}) end)
    end
  end

end
