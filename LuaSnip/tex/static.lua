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
-- Return snippet tables
return
  {
    s({trig="q"},
      {
        t("\\quad "),
      }
    ),
    s({trig="qq", snippetType="autosnippet"},
      {
        t("\\qquad "),
      }
    ),
    s({trig="npp", snippetType="autosnippet"},
      {
        t({"\\newpage", ""}),
      },
      {condition = line_begin}
    ),
    s({trig="inff", snippetType="autosnippet"},
      {
        t("\\infty"),
      }
    ),
    s({trig="ii", snippetType="autosnippet"},
      {
        t("\\item "),
      },
      { condition = line_begin }
    ),
    s({trig = "--", snippetType="autosnippet"},
      {t('% --------------------------------------------- %')},
      {condition = line_begin}
    ),
    -- HLINE WITH EXTRA VERTICAL SPACE
    s({trig = "hl"},
      {t('\\hline {\\rule{0pt}{2.5ex}} \\hspace{-7pt}')},
      {condition = line_begin}
    ),
  }
