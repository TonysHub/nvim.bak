vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.skip_ts_context_commentstring_module = true

vim.loader.enable()

vim.cmd('highlight Cursor guifg=NONE guibg=white')
require("tonylee")
require("notify").setup({
  stages = "fade_in_slide_out",
  timeout = 500,
  background_colour = "#000000",
  icons = {
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
})
