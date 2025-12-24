
local ls = require("luasnip")
local s,t,i = ls.snippet, ls.text_node, ls.insert_node

ls.add_snippets("cpp", {
  s("cout", {
    t("std::cout << "),
    i(1),
    t(" << std::endl;")
  }),
})
