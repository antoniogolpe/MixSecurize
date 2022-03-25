defmodule UnsafeToAtomCheck do
  @behaviour Securize.Checker

  @message "Creating atoms from unknown or external sources dynamically is a potentially unsafe operation because atoms are not garbage-collected by the runtime. Prefer the use of `String.to_existing_atom` instead."

  @impl true
  def run(ast) do
    {_ast, issues} = Macro.postwalk(ast, [], &traverse/2)
    issues
  end

  defp traverse({{:., _, [{:__aliases__, _, [:String]}, :to_atom]},
    meta, _args} = node, acc) do
    issue = %{
      message: @message,
      line: meta[:line],
      column: meta[:column]
    }
    {node, [issue | acc]}
  end

  defp traverse(node, acc), do: {node, acc}
end
