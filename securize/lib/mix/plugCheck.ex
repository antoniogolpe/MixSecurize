defmodule PlugChecker do
  @behaviour Securize.Checker

  @messageStatic "Attention! This Plug Static version is vulnerable to null byte injection. We recommend upgrade it immediately."
  @messageSession "Attention! This Plug Session version is vulnerable to code injecting. We recommend upgrade it immediately."
  @messageNoVersion "Attention! Plug library version could not be detected. We recommend having it updated."

  @impl true
  def run(ast, deps) do
    {_ast, [issues,_]} = Macro.postwalk(ast, [[], deps], &traverse/2)
    issues
  end

  defp checkVersion(deps) do
    #Enum.map(deps, fn [x,y] -> check(x,y) end)
    Enum.any?( Enum.map(Map.get(deps,:plug), fn value ->
      (Version.match?(value, "< 1.0.4") || Version.match?(value, ">= 1.1.0 and < 1.1.7")
      || Version.match?(value, ">= 1.2.0 and < 1.2.3") || Version.match?(value, ">= 1.3.0 and < 1.3.2"))
    end))

  end

  defp detectVulnerability(node, [acc, deps], meta, message) do
    if(Map.has_key?(deps, :plug)) do
      if(checkVersion(deps)) do
        issue = %{
          message: message,
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

  defp traverse({
    :__aliases__, meta, [:Plug, :Static]
  } = node, acc) do
    detectVulnerability(node, acc, meta, @messageStatic)
  end

  defp traverse({
    :__aliases__, meta, [:Plug, :Session]
  } = node, acc) do
    detectVulnerability(node, acc, meta, @messageSession)
  end

  defp traverse(node, acc), do: {node, acc}

end
