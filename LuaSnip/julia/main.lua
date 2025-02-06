local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin
local utils = require("user.utils")

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else
    return sn(nil, i(1))
  end
end

-- Return snippet tables
return
  {
    -- PRINT STATEMENT
    s({trig="pp", snippetType="autosnippet"},
      fmta(
        [[print(<>)]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Function definition with choice node docstring
    -- The idea is to let you choose if you want to use the docstring or not
    s({trig="ff", snippetType="autosnippet"},
      fmta(
        [[
      function <>(<>)
          <>
      end
      ]],
        {
          i(1),
          i(2),
          d(3, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- for in
    s({trig="frr", snippetType = "autosnippet"},
      fmta(
        [[
	for <> in <>
	    <>
	end
      ]],
        {
          i(1),
          i(2),
          d(3, get_visual)
        }
      ),
      {condition = line_begin}
    ),
    -- IF STATEMENT
    s({trig="iff", snippetType = "autosnippet"},
      fmta(
        [[
        if <>
            <>
        end
      ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- RETURN STATEMENT
    s({trig = ";r", snippetType = "autosnippet"},
      { t("return") },
      { condition = line_begin }
    ),
    -- Common Packages to load
    s({trig=";u", snippetType = "autosnippet"},
      fmta(
        [[
	using LinearAlgebra, Statistics, Random<>
	Random.seed!(<>)
      ]],
        {
          i(1),
          d(2, get_visual),
        }
      ),
      {condition = line_begin}
    ),
    -- Today's date
    s({trig = ",d", snippetType = "autosnippet"},
      { t(utils.get_date()) }
    ),
    s({trig="##", snippetType = "autosnippet"},
      fmta(
        [[
################################################################################
<>
      ]],
        {
          d(1, get_visual),
        }
      ),
      {condition = line_begin}
    ),

    -- -- KWARGS STATEMENT
    -- s({trig = ";k", snippetType = "autosnippet", wordTrig=false},
    --   { t("kwargs") }
    -- ),
    -- -- KWARGS.GET
    -- s({trig="kgg", snippetType = "autosnippet"},
    --   fmta(
    --     [[
    --     kwargs.get('<>', '<>')
    --     ]],
    --     {
    --       d(1, get_visual),
    --       i(2)
    --     }
    --   )
    -- ),
  }
