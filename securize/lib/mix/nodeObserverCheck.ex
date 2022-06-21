defmodule ObserverStart do
  @behaviour Securize.Checker

  @message ":observer.start REQUIRES the usage of the cookie-based node system"

    @impl true
    def run(ast) do
      {_ast, issues} = Macro.postwalk(ast, [], &traverse/2)
      issues
    end

    defp traverse({
      {:.,_, [:observer, :start]},meta,_
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
