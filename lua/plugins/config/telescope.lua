pcall(require('telescope').load_extension, 'fzf')

local Remap = require("tonylee.keymap")
local nnoremap = Remap.nnoremap

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

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

nnoremap('<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
nnoremap('<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
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
nnoremap('<leader>sg', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
nnoremap('<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
nnoremap('<leader>pf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
nnoremap('<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
nnoremap('<leader>pw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
nnoremap('<leader>ps', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
nnoremap('<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
nnoremap('<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
nnoremap('<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
