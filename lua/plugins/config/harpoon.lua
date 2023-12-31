local Remap = require("tonylee.keymap")
local nnoremap = Remap.nnoremap
local harpoon = require("harpoon")

harpoon:setup({})

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

nnoremap("<leader>a", function() harpoon:list():append() end)
nnoremap("<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

for i = 1, 10 do
    nnoremap("<leader>" .. i % 10, function() harpoon:list():select(i) end, silent)
end

nnoremap("<C-S-P>", function() harpoon:list():prev() end)
nnoremap("<C-S-N>", function() harpoon:list():next() end)
