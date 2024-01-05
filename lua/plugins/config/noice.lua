local notify = require("notify")
notify.setup({ fps = 120, render = "minimal", timeout = 500 })

require("noice").setup({
    cmdline = {
        format = {
            bash = {
                kind = "bash",
                pattern = "^:!",
                icon = "$",
                lang = "bash",
            },
            search_and_replace = {
                kind = "replace",
                pattern = "^:%%?s/",
                icon = " ",
                lang = "regex",
            },
            search_and_replace_range = {
                kind = "replace",
                pattern = "^:'<,'>%%?s/",
                icon = " ",
                lang = "regex",
            },
        },
    },
    lsp = {
        progress = {
            enabled = false
        },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = true,         -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
    throttle = 1000 / 120,
    routes = {
        {
            filter = { event = "msg_show", kind = "", find = "written" },
            opts = { skip = true },
        },
    },
    views = {
        cmdline_popup = {
            position = { row = vim.o.lines * 0.32, col = "50%" },
            size = { width = 60, height = "auto" },
        },
        popupmenu = {
            position = { row = vim.o.lines * 0.32 + 3, col = "50%" },
            size = { width = 60, height = 10 },
            border = { style = "rounded", padding = { 0, 1 } },
            win_options = {
                winhighlight = {
                    Normal = "Normal",
                    -- FloatBorder = "DiagnosticInfo",
                },
            },
        },
    },
})
