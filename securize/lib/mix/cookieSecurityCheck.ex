defmodule CookieSecurity do
  @behaviour Securize.Checker

  #:erlang.set_cookie/2
  #erlang:set_cookie/2
  @message "Attention! You are using distributed node system. For greater security use different cookies for each node"

  @impl true
  def run(ast, _) do
    {_ast, issues} = Macro.postwalk(ast, [], &traverse/2)
    issues
  end

  defp traverse({
    {:.,_, [
      {:__aliases__, _,
        [:Node]},
        :spawn_link
    ]},
    meta,_
  } = node, acc) do
    issue = %{
      message: @message,
      line: meta[:line],
      column: meta[:column]
    }
    {node, [issue | acc]}
  end

  defp traverse({
    {:.,_, [
      {:__aliases__, _,
        [:Node]},
        :spawn
    ]},
    meta,_
  } = node, acc) do
    issue = %{
      message: @message,
      line: meta[:line],
      column: meta[:column]
    }
    {node, [issue | acc]}
  end

  defp traverse({
    {:.,_, [
      {:__aliases__, _,
        [:Node]},
        :connect
    ]},
    meta,_
  } = node, acc) do
    issue = %{
      message: @message,
      line: meta[:line],
      column: meta[:column]
    }
    {node, [issue | acc]}
  end

  defp traverse({
    {:.,_, [
      {:__aliases__, _,
        [:Node]},
        :set_cookie
    ]},
    meta,_
  } = node, acc) do
    issue = %{
      message: @message,
      line: meta[:line],
      column: meta[:column]
    }
    {node, [issue | acc]}
  end

  defp traverse({
    {:.,_, [
      {:__aliases__, _,
        [:Node]},
        :start
    ]},
    meta,_
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
