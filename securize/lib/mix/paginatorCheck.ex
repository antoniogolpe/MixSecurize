defmodule PaginatorChecker do
  @behaviour Securize.Checker

  @message "Attention! This Paginator version has a vulnerability. We recommend upgrade it immediately."
  @messageNoVersion "Attention! Paginator library version could not be detected. We recommend having it updated."

    @impl true
    def run(ast, deps) do
      {_ast, [issues,_]} = Macro.postwalk(ast, [[], deps], &traverse/2)
      issues
    end

    defp checkVersion(deps) do
      #Enum.map(deps, fn [x,y] -> check(x,y) end)
      Enum.any?( Enum.map(Map.get(deps,:paginator), fn value ->
        (Version.match?(value, "< 1.0.0"))
      end))
    end

    defp detectVulnerability(node, [acc, deps], meta) do
      if(Map.has_key?(deps, :paginator)) do
        if(checkVersion(deps)) do
          issue = %{
            message: @message,
            line: meta[:line],
            column: meta[:column]
          }
          {node, [[issue | acc], deps]}
        else
          {node, [acc, deps]}
        end
      else
        issue = %{
          message: @messageNoVersion,
          line: meta[:line],
          column: meta[:column]
        }
        {node, [[issue | acc], deps]}
      end
    end

    defp traverse({{:., _,[{:__aliases__, _, [_, :Repo]}, :paginate]}, meta, _} = node, acc) do
      detectVulnerability(node, acc, meta)
    end

    defp traverse({{:., _,[{:__aliases__, _, [:Repo]}, :paginate]}, meta, _} = node, acc) do
      detectVulnerability(node, acc, meta)
    end

    defp traverse(node, acc) do
      {node, acc}
    end
  end
