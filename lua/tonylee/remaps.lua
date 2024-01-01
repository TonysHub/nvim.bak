local Remap = require("tonylee.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap
local vnoremap = Remap.vnoremap

local silent = { silent = true }

-- easier to enter normal mode
inoremap("<c-c>", "<esc>")

-- built in terminal
nnoremap("<C-t>", "<Cmd>sp<CR> <Cmd>term<CR> <Cmd>resize 20N<CR> i", silent)

-- writing
nnoremap("<C-s>", "<Cmd>set spell!<CR>", silent)

-- misc
nnoremap("<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", silent)
nnoremap("<leader>q", "<Cmd>q<CR>", silent)
nnoremap("<leader>w", "<Cmd>w<CR>", silent)

-- shift current line up & down
vnoremap("J", ":m '>+1<CR>gv=gv", silent)
vnoremap("K", ":m '<-2<CR>gv=gv", silent)

-- append line from below
nnoremap("J", "mzJ`z")

-- move cursor up & down
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- open previous tab
nnoremap("<leader><Tab>", "<C-^>")

-- copy paste related
nnoremap("<leader>y", [["+y]])
vnoremap("<leader>y", [["+y]])

-- select all
vnoremap("<leader>g", "ggVG<CR>", silent)
nnoremap("<leader>g", "ggVG<CR>", silent)

-- apply formatting
-- nnoremap("<leader>f", vim.lsp.buf.format)

-- terminal
nnoremap("<leader>t", "<Cmd>sp<CR> <Cmd>term<CR> <Cmd>resize 13N<CR> i", silent)
tnoremap("<C-c><C-c>", "<C-\\><C-n>", silent)
tnoremap("<D-v>", function()
  local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>\"+pi", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, silent)

-- move through buffers
nnoremap("<C-k>", "<C-w>k", silent)
nnoremap("<C-h>", "<C-w>h", silent)
nnoremap("<C-j>", "<C-w>j", silent)
nnoremap("<C-l>", "<C-w>l", silent)

-- cycle through buffers
nnoremap("<S-h>", "<cmd>BufferLineCyclePrev<cr>")
nnoremap("<S-l>", "<cmd>BufferLineCycleNext<cr>")

-- indent
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- split buffers
nnoremap("|", "<C-w>v", silent)
nnoremap("-", "<C-w>s", silent)

-- Diagnostic keymaps
nnoremap('<leader>dt', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
nnoremap('<leader>dn', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
nnoremap('<leader>do', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
nnoremap('<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
