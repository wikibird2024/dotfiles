
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node

ls.add_snippets("rust", {

  -- fn main()
  s("fnm", {
    t("fn main() {\n    "),
    i(1),
    t("\n}")
  }),

  -- println!
  s("pl", {
    t('println!("'),
    i(1),
    t('");')
  }),

  -- match
  s("mt", {
    t("match "),
    i(1, "value"),
    t({ " {", "    " }),
    i(2, "pattern"),
    t(" => "),
    i(3),
    t({ ",", "}" })
  }),

})
