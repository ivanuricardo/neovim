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

return {
    -- Notes Template
    s({ trig = "template", snippetType = "autosnippet" },
      fmta(
        [[
	\documentclass[12pt]{article}
	 
	\usepackage[margin=1in]{geometry} 
	\usepackage{amsmath,amsthm,amssymb,graphicx,mathtools,tikz,hyperref}
	\usepackage{bm}
	\usetikzlibrary{positioning}
	\newcommand\proofs[1]{\begin{proof}#1\end{proof}}
	\setcounter{MaxMatrixCols}{25}

	\newenvironment{theorem}[2][Theorem]{\begin{trivlist}
	\item[\hskip \labelsep {\bfseries #1}\hskip \labelsep {\bfseries #2.}]}{\end{trivlist}}
	\newenvironment{lemma}[2][Lemma]{\begin{trivlist}
	\item[\hskip \labelsep {\bfseries #1}\hskip \labelsep {\bfseries #2.}]}{\end{trivlist}}
	\newenvironment{exercise}[2][Exercise]{\begin{trivlist}
	\item[\hskip \labelsep {\bfseries #1}\hskip \labelsep {\bfseries #2.}]}{\end{trivlist}}
	\newenvironment{proposition}[2][Proposition]{\begin{trivlist}
	\item[\hskip \labelsep {\bfseries #1}\hskip \labelsep {\bfseries #2.}]}{\end{trivlist}}
	\newenvironment{corollary}[2][Corollary]{\begin{trivlist}
	\item[\hskip \labelsep {\bfseries #1}\hskip \labelsep {\bfseries #2.}]}{\end{trivlist}}
	 \hypersetup{
	 colorlinks,
	 linkcolor=blue
	 }
	\begin{document}
	\date{\today}

	 
	\title{<>}
	\author{Ivan Ricardo}
	 
	\maketitle
	\section{<>}
	<>

	\end{document}
        ]],
        {
          i(1),
          i(2),
          i(3),
        }
      ),
      { condition = line_begin }
    ),
    -- Generic Environment
    s({ trig = "new", snippetType = "autosnippet" },
      fmta(
        [[
        \begin{<>}
            <>
        \end{<>}
        ]],
        {
          i(1),
          i(2),
          rep(1),
        }
      ),
      { condition = line_begin }
    ),

    -- Equation Environment (Shortcut: nn)
    s({ trig = "nn", snippetType = "autosnippet" },
      fmta(
        [[
        \begin{equation*}
            <>
        \end{equation*}
        ]],
        {
          i(1),
        }
      ),
      { condition = line_begin }
    ),
    -- ALIGN
    s({trig="all", snippetType="autosnippet"},
      fmta(
        [[
        \begin{align*}
            <>
        \end{align*}
      ]],
        {
          i(1),
        }
      ),
      {condition = line_begin}
    ),
    -- INLINE MATH
    s({trig = "([^%l])mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>$<>$",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
    -- ITEMIZE
    s({trig="itt", snippetType="autosnippet"},
      fmta(
        [[
        \begin{itemize}

            \item <>

        \end{itemize}
      ]],
        {
          i(0),
        }
      ),
      {condition = line_begin}
    ),
    -- Fractions (Regex Trigger: ff)
    s({ trig = '([^%a])ff', regTrig = true, wordTrig = false, snippetType = "autosnippet" },
      fmta(
        [[<>\frac{<>}{<>}]],
        {
          f(function(_, snip) return snip.captures[1] end),
          i(1),
          i(2),
        }
      )
    ),
    -- Hyperref Href Command (Trigger: hr)
    s({ trig = "hr", dscr = "The hyperref package's href{}{} command (for URL links)" },
      fmta(
        [[\href{<>}{<>}]],
        {
          i(1, "url"),
          i(2, "display name"),
        }
      )
    ),

    -- Equation Environment (Trigger: eq)
    s({ trig = "eq", dscr = "Expands 'eq' into an equation environment" },
      fmta(
        [[
        \begin{equation*}
            <>
        \end{equation*}
        ]],
        {
          i(1),
        }
      )
    ),
    -- INLINE MATH ON NEW LINE
    s({trig = "^mm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "$<>$",
{
          i(1),
        })),
    -- FIGURE
    s({trig = "fig"},
      fmta(
        [[
        \begin{figure}[htb!]
          \centering
          \includegraphics[width=<>\linewidth]{<>}
          \caption{<>}
          \label{fig:<>}
        \end{figure}
        ]],
        {
          i(1),
          i(2),
          i(3),
          i(4),
        }
      ),
      { condition = line_begin }
    ),
}
