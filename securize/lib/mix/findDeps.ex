defmodule FindDeps do

  defp traverse({:plug, texto}=node,acc) do
    version = Regex.scan(~r/[0-9.]+/,texto)|> List.flatten()
    {node, Map.put_new(acc, :plug, version)}
  end

  defp traverse({:{}, [_,_], [:plug, texto, [_]]} = node, acc) do
    version = Regex.scan(~r/[0-9.]+/,texto)|> List.flatten()
    {node, Map.put_new(acc, :plug, version)}
  end

  defp traverse({:paginator, texto}=node,acc) do
    version = Regex.scan(~r/[0-9.]+/,texto)|> List.flatten()
    {node, Map.put_new(acc, :paginator, version)}
  end

  defp traverse({:{}, [_,_], [:paginator, texto, [_]]} = node, acc) do
    version = Regex.scan(~r/[0-9.]+/,texto)|> List.flatten()
    {node, Map.put_new(acc, :paginator, version)}
  end

  defp traverse(node, acc) do
    {node,acc}
  end

  def findDeps(file) do
    a = file
    |> Path.expand()
    |> File.read!()

    [completo | _] =  Regex.run(~r/def\s+deps\s+do(([^\]]|\n)*)\]\s*(?:end|end(.|\n)*end(*FAIL))/, a)
    # def\s+deps\s+do(([^\]]|\n)*)\]


    #Regex.scan(~r/{[^}]+}/, completo)
    deps = Regex.scan(~r/{\s*(?<nombre>[^},]+)\s*,\s*(?<version>[^},]+)\s*(,[^}]+)?}/, completo, capture: ["nombre", "version"])

    Enum.map(deps, fn [_,y] -> Regex.scan(~r/[0-9.]+/, y) end)|> List.flatten()

  end

  def findDeps2(file) do
    ast =
      file
      |> Path.expand()
      |> File.read!()
      |> Code.string_to_quoted(columns: true)

    {_ast, versions} = Macro.postwalk(ast, Map.new(), &traverse/2)
    versions
  end
end
