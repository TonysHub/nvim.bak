local nnoremap = require("tonylee.keymap").nnoremap

vim.opt.termguicolors = true

require("mini.bufremove").setup {}

nnoremap("<leader>bd", function() require("mini.bufremove").delete(0, false) end)
nnoremap("<leader>bD", function() require("mini.bufremove").delete(0, true) end)
