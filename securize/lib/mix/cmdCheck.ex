defmodule Cmd do
  @behaviour Securize.Checker

  @message "cmd error"

    @impl true
    def run(ast, _) do
      {_ast, issues} = Macro.postwalk(ast, [], &traverse/2)
      issues
    end

    defp traverse({
      {:.,_,[:os, :cmd]},meta,_
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
