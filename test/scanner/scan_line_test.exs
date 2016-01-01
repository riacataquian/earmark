defmodule Earmark.Scanner.ScanLineTest do
  use ExUnit.Case

  alias Earmark.Scanner

  [ 
    { "",           [ %Scanner.EmptyLine{}] },
    { "alpha beta", [ %Scanner.Text{content: "alpha beta"}] },
    { " alpha",     [ %Scanner.Text{content: " alpha"}] },
    { "   alpha",   [ %Scanner.Text{content: "   alpha"}] },

    # Indent
    { "    alpha",          [ %Scanner.Indent{count: 4},%Scanner.Text{content: "alpha"}] },
    { "     alpha",         [ %Scanner.Indent{count: 5},%Scanner.Text{content: "alpha"}] },
    { "     # no headline", [ %Scanner.Indent{count: 5},%Scanner.Text{content: "# no headline"}] },

    # Rulers
    { "***",     [ %Scanner.RulerFat{}] },
    { "_ ___ _", [ %Scanner.RulerMedium{}] },
    { "---",     [ %Scanner.RulerThin{}] },
    { "  ---",   [ %Scanner.RulerThin{}] },
    { "_ _",     [ %Scanner.Text{content: "_ _"}] },
    { "**",      [ %Scanner.Text{content: "**"}] },

    # Headlines
    { "#",      [ %Scanner.Text{content: "#"}]},
    { " #",     [ %Scanner.Text{content: " #"}]},
    { "##",     [ %Scanner.Text{content: "##"}]},
    { "###xxx", [ %Scanner.Text{content: "###xxx"}]},
    { "# ",     [ %Scanner.Headline{level: 1}]},
    { "###  ",  [ %Scanner.Headline{level: 3}]},
    { "###### Hello `World`", [
      %Scanner.Headline{level: 6},
      %Scanner.Text{content: "Hello "},
      %Scanner.Backtix{count: 1},
      %Scanner.Text{content: "World"},
      %Scanner.Backtix{count: 1}]},
    { "####   3 * 2", [ %Scanner.Headline{level: 4},%Scanner.Text{content: "3 * 2"}]},
    { "####### text", [ %Scanner.Text{content: "####### text"}]},
    { " # Hello",     [ %Scanner.Text{content: " # Hello"}]},

    # Backtix
    { "`",           [ %Scanner.Backtix{count: 1}]},
    { " `````a",     [ %Scanner.Text{content: " "},%Scanner.Backtix{count: 5},%Scanner.Text{content: "a"}]},
    { "     `````a", [ %Scanner.Indent{count: 5},%Scanner.Backtix{count: 5},%Scanner.Text{content: "a"}]},

    # CodeFences
    { "~~~",        [ %Scanner.CodeFence{}]},
    { "  ~~~alpha", [ %Scanner.Text{content: "  "},%Scanner.CodeFence{}, %Scanner.Text{content: "alpha"}]},

    # UnderHeadline N.B. Semantics of RulerThin depend on the context
    { "= ",      [ %Scanner.UnderHeadline{level: 1}]},
    { "-",       [ %Scanner.UnderHeadline{level: 2}]},
    { "-- ",     [ %Scanner.UnderHeadline{level: 2}]},
    { "--- ",    [ %Scanner.RulerThin{}]},
    { " =",      [ %Scanner.Text{content: " ="}]},
    { "    ---", [ %Scanner.Indent{count: 4}, %Scanner.Text{content: "---"}]},

    # ListItem
    { "* x",       [ %Scanner.ListItem{type: :ul, bullet: "*"}, %Scanner.Text{content: "x"}]},
    { "- x",       [ %Scanner.ListItem{type: :ul, bullet: "-"}, %Scanner.Text{content: "x"}]},
    { "- =",       [ %Scanner.ListItem{type: :ul, bullet: "-"}, %Scanner.Text{content: "="}]},
    { "100. x",    [ %Scanner.ListItem{type: :ol, bullet: ""}, %Scanner.Text{content: "x"}]},
    { "   100. x", [ %Scanner.Text{content: "   "}, %Scanner.ListItem{type: :ol, bullet: ""}, %Scanner.Text{content: "x"}]},
    { " * x",      [ %Scanner.Text{content: " "}, %Scanner.ListItem{type: :ul, bullet: "*"}, %Scanner.Text{content: "x"}]},
    { "     * x",  [ %Scanner.Indent{count: 5}, %Scanner.Text{content: "* x"}]},
    { "*x",        [ %Scanner.Text{content: "*x"}]},
    { " *x",       [ %Scanner.Text{content: " *x"}]},
    
    # Blockquote
    { ">",         [ %Scanner.Blockquote{} ]},
    { "> alpha",   [ %Scanner.Blockquote{}, %Scanner.Text{content: " alpha"} ]},
    { ">alpha",    [ %Scanner.Text{content: ">alpha"}]},
    { " >",        [ %Scanner.Text{content: " >"}]},
  ]
  |> Enum.each(fn { text, tokens } -> 
    test("line: '" <> text <> "'") do
      assert Scanner.scan_line(unquote(text)) == unquote(Macro.escape(tokens))
    end
  end)
end
