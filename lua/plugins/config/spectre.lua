local Remap = require("tonylee.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local silent = { silent = true }

local spectre = require("spectre")
spectre.setup()

nnoremap("<leader>so", '<cmd>lua require("spectre").toggle()<CR>', silent)
vnoremap("<leader>so", spectre.open_visual)
