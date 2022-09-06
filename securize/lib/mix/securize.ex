defmodule Securize do
  defmodule Checker do
    @type issue :: %{
      message: String.t,
      line: integer,
      columns: integer
    }

    @callback run(ast :: any, deps:: any) :: [issue]
  end

  @checkers [CmdChecker,CookieSecurityChecker,PlugChecker,PaginatorChecker]

  defp fileToQuoted(file, deps) do
    ast =
      file
      |> Path.expand()
      |> File.read!()
      |> Code.string_to_quoted(columns: true)

    issues =
      Enum.map(@checkers, fn checker -> checker.run(ast, deps) end)
      |> List.flatten()

    if(!Enum.empty?(issues)) do
      Enum.each(issues, fn issue -> print_issue(file, issue) end)
      true
    else
      false
    end
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

  defp checkDeps(filesAuxs) do
    listDeps = Enum.map(filesAuxs, fn exs -> FindDeps.findDeps(exs) end)
    if(!Enum.empty?(listDeps)) do
      Enum.reduce(listDeps, fn x, y ->
          Map.merge(x, y, fn _k, v1, v2 -> v2 ++ v1 end)end)
    else
      %{}
    end
  end

  def securize(files, filesAuxs) do
    #deps = Enum.concat(Enum.map(filesAuxs, fn exs -> FindDeps.findDeps2(exs) end))
    #deps = Enum.map(filesAuxs, fn exs -> FindDeps.findDeps2(exs) end)
    deps = checkDeps(filesAuxs)
    issues = Enum.map(files, fn file -> fileToQuoted(file,deps) end)
    if(!Enum.any?(issues)) do
      "No se encontro ninguna vulnerabilidad"|> IO.puts
    end

  end

end
