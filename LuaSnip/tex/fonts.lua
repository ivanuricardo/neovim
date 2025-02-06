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

-- Return snippet tables
return
  {
    -- ITALIC i.e. \textit
    s({trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>\\textit{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
    -- BOLD i.e. \textbf
    s({trig = "tbb", snippetType="autosnippet"},
      fmta(
        "\\textbf{<>}",
        {
          d(1, get_visual),
        }
      )
    ),
    -- MATH ROMAN i.e. \mathrm
    s({trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>\\mathrm{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
    -- MATH CALIGRAPHY i.e. \mathcal
    s({trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>\\mathcal{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
    -- MATH BOLDFACE i.e. \mathbf
    s({trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>\\mathbf{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
    -- MATH BOLDFACE pt 2 i.e. \bm{}
    s({trig = "([^%a])bb", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>\\bm{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),

    -- Set of Reals
    s({trig = "RR", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>\\mathbb{R}^{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        },
	{condition = tex.in_mathzone}
      )
    ),
    -- MATH BLACKBOARD i.e. \mathbb
    s({trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType="autosnippet"},
      fmta(
        "<>\\mathbb{<>}",
        {
          f( function(_, snip) return snip.captures[1] end ),
          d(1, get_visual),
        }
      )
    ),
  }
