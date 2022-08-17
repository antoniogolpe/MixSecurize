defmodule MultiAliasCheck do
@behaviour Securize.Checker

  @message """
  Multi alias expansion makes module uses harder to search for in large code bases.
      # Preferred
      alias Foo.Boo
      alias Foo.Baz

      # NOT preferred
      alias Foo.{Bar, Baz}
  """

  @impl true
  def run(ast, _) do
    {_ast, issues} = Macro.postwalk(ast, [], &traverse/2)
    issues
  end

  defp traverse({
    :alias, _,
    [{
      {:., _, [{:__aliases__, meta, _}, :{}]},
      _, _
    }]
  } = node, acc) do
    issue = %{
      message: @message,
      line: meta[:line],
      column: meta[:column]
    }
    {node, [issue | acc]}
  end

  defp traverse(node, acc), do: {node, acc}
end
