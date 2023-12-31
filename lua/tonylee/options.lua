local options = {
  autoindent = true,
  backup = false,
  breakindent = true,
  clipboard = 'unnamedplus',
  colorcolumn = "80",
  completeopt = 'menuone,noselect',
  cursorline = true,
  errorbells = false,
  expandtab = true,
  fileencoding = "utf-8",
  -- guicursor = "a:block",
  guifont = "MesloLGS NF:h18",
  hidden = true,
  hlsearch = false,
  ignorecase = true,
  incsearch = true,
  mouse = "a",
  number = true,
  numberwidth = 4,
  scrolloff = 15,
  shiftwidth = 4,
  showmatch = true,
  showmode = false,
  showtabline = 0,
  signcolumn = "yes",
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 4,
  termguicolors = true,
  timeoutlen = 300,
  title = true,
  titlestring = "Neovim - %t",
  relativenumber = true,
  wrap = false,
  writebackup = false,
  updatetime = 250,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
}

vim.opt.shortmess:append("IsF")

vim.cmd([[
augroup FileTypeOverrides
autocmd!
autocmd FileType javascript setlocal shiftwidth=2
autocmd FileType javascriptreact setlocal shiftwidth=2
autocmd FileType typescript setlocal shiftwidth=2
autocmd FileType typescriptreact setlocal shiftwidth=2
augroup END
]])

for option, value in pairs(options) do
  vim.opt[option] = value
end
