local Remap = require("tonylee.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>u", vim.cmd.UndotreeToggle)
