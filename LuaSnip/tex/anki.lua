local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

local tex = {}
tex.in_mathzone = function() return vim.fn['vimtex#syntax#in_mathzone']() == 1 end
tex.in_text = function() return not tex.in_mathzone() end

return
{
    -- Anki Template
    s({ trig = "anki", snippetType = "autosnippet" },
      fmta(
        [[
	\begin{note}
	   \begin{field}
	       <>
	   \end{field}
	   \begin{field}
	       <>
	   \end{field}
	\end{note}
        ]],
        {
          i(1),
          i(2),
        }
      ),
      { condition = line_begin }
    ),

    -- Anki Template
    s({ trig = "mydoc", snippetType = "autosnippet" },
      fmta(
        [[
	\documentclass[12pt]{article}
	\usepackage[utf8]{inputenc}
	\newenvironment{note}{\paragraph{NOTE:}}{}
	\newenvironment{field}{\paragraph{field:}}{}
	\begin{document}
	<>
	\end{document}
        ]],
        {
          i(1),
        }
      ),
      { condition = line_begin }
    ),
}
