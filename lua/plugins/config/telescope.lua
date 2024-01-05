local Remap = require("tonylee.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

local actions = require("telescope.actions")
local function find_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

nnoremap('<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
nnoremap('<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
nnoremap('<leader>p/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
-- nnoremap('<leader>sg', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
nnoremap('<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
nnoremap('<leader>pf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
nnoremap('<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
nnoremap('<leader>pw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
nnoremap('<leader>ps', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
nnoremap('<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
nnoremap('<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
nnoremap('<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vnoremap('<leader>ps', function()
  local text = vim.getVisualSelection()
  require('telescope.builtin').live_grep({ default_text = text })
end, { desc = '[S]earch [V]isual [S]election' })


require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
      },
    },
    layout_config = {
      width = 0.85,
      preview_cutoff = 120,
      horizontal = {
        preview_width = function(_, cols, _)
          if cols < 120 then
            return math.floor(cols * 0.5)
          end
          return math.floor(cols * 0.6)
        end,
        mirror = false,
      },
      vertical = { mirror = false },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    file_ignore_patterns = {
      "node_modules/",
      "%.git/",
      "%.DS_Store$",
      "target/",
      "build/",
      "%.o$",
    },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
  pickers = {
    find_files = { hidden = true },
    live_grep = {
      -- @usage don't include the filename in the search results
      only_sort_text = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("lazygit")
