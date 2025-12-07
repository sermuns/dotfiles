local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets('python', {
  s('///', {
    t '# /// script\n# dependencies = [\n#   "',
    i(1),
    t '",\n# ]\n# ///',
  }),
})
