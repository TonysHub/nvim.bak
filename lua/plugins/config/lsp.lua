-- local on_attach = function(_, bufnr)
--   local nmap = function(keys, func, desc)
--     if desc then
--       desc = 'LSP: ' .. desc
--     end
--
--     vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--   end
--
-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
-- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
-- nmap("gd", function() vim.lsp.buf.definition() end, '[G]oto [D]efinition')
-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
-- nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
-- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
-- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
-- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
-- nmap('<leader>f', vim.lsp.buf.format, '[F]ormat')
-- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
-- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
-- -- Lesser used LSP functionality
-- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
-- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
-- nmap('<leader>wl', function()
--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
-- end, '[W]orkspace [L]ist Folders')
-- end


-- local servers = {
--   -- clangd = {},
--   -- gopls = {},
--   rust_analyzer = {},
--   tsserver = {
--     settings = {
--       formatting = true,
--       formatoptions = {
--         tabSize = 2,
--         useTabs = false,
--       },
--     },
--   },
--   efm = {
--     init_options = { documentFormatting = true },
--     filetypes = { "javascript", "javascriptreact", "jsx" },
--     settings = {
--       rootMarkers = { ".eslintrc.js", ".eslintrc.json", "package.json" },
--       languages = {
--         javascript = { { formatCommand = "prettier --no-semi --write", formatStdin = true } },
--         javascriptreact = { { formatCommand = "prettier --no-semi --write", formatStdin = true } },
--         jsx = { { formatCommand = "prettier --no-semi --write", formatStdin = true } },
--       }
--     }
--   },
--   html = { filetypes = { 'html', 'twig', 'hbs' } },
--   pylsp = {
--     plugins = {
--       flake8 = {
--         enabled = true,
--         ignore = { "E501", "E126", "E121", "E123" }
--       },
--       mccabe = {
--         enabled = true
--       },
--       pyflakes = {
--         enabled = true
--       },
--       black = {
--         enabled = true
--       },
--       isort = {
--         enabled = true
--       },
--     }
--   },
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--       diagnostics = { disable = { 'missing-fields' } },
--     },
--   },
-- }
--
-- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     }
--   end,
-- }
-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local lsp_zero = require('lsp-zero')
--
-- lsp_zero.on_attach = on_attach
--
-- local default_setup = function(server)
--   require('lspconfig')[server].setup({
--     capabilities = lsp_capabilities,
--   })
-- end
--
--
-- -- mason requires this order of setup
-- require('mason').setup({})
-- require('mason-lspconfig').setup({
--   ensure_installed = {
--     'pyright',
--     'rust_analyzer',
--     'tsserver',
--     'html',
--     'efm',
--   },
--   handlers = {
--     default_setup,
--   },
-- })

-- require('lspconfig').lua_ls.setup({
--   capabilities = lsp_capabilities,
--   settings = {
--     Lua = {
--       runtime = {
--         version = 'LuaJIT'
--       },
--       diagnostics = {
--         globals = {'vim'},
--       },
--       workspace = {
--         library = {
--           vim.env.VIMRUNTIME,
--         }
--       }
--     }
--   }
-- })
--
-- require('lspconfig').pylsp.setup({
--   capabilities = lsp_capabilities,
--   settings = {
--     pylsp = {
--       plugins = {
--         flake8 = {
--           enabled = true,
--           ignore = { "E501", "E126", "E121", "E123" }
--         },
--         mccabe = {
--           enabled = true
--         },
--         pyflakes = {
--           enabled = true
--         },
--         black = {
--           enabled = true
--         },
--         isort = {
--           enabled = true
--         },
--       }
--     }
--   }
-- })
--
-- require

local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'lua_ls',
  'pylsp',
  'html',
})


-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ['<Tab>'] = nil,
  ['<S-Tab>'] = nil
})
--
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap("gd", function() vim.lsp.buf.definition() end, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>f', vim.lsp.buf.format, '[F]ormat')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap("[d", function() vim.diagnostic.goto_next() end)
  nmap("]d", function() vim.diagnostic.goto_prev() end)
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end

lsp.on_attach(on_attach)

local pylsp_config = {
  pylsp = {
    plugins = {
      pycodestyle = {
        enabled = false,
        ignore = { "E501" }
      },
      flake8 = {
        enabled = true,
        ignore = { "E501", "E126", "E121", "E123" }
      },
      mccabe = {
        enabled = true
      },
      pyflakes = {
        enabled = true
      },
      isort = {
        enabled = true
      },
    }
  }
}
local tsserver_config = {
  settings = {
    -- Add this block to enforce 2-space indentation for JavaScript/TypeScript
    formatting = true,
    formatoptions = {
      tabSize = 2,
      useTabs = false,
    },
  }
}

local efm_config = {
  init_options = { documentFormatting = true },
  filetypes = { "javascript", "javascriptreact", "jsx" },
  settings = {
    rootMarkers = { ".eslintrc.js", ".eslintrc.json", "package.json" },
    languages = {
      javascript = { { formatCommand = "prettier --no-semi --write", formatStdin = true } },
      javascriptreact = { { formatCommand = "prettier --no-semi --write", formatStdin = true } },
      jsx = { { formatCommand = "prettier --no-semi --write", formatStdin = true } },
    }
  }
}
require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'rust_analyzer',
    'lua_ls',
    'pylsp',
    'html',
    'efm',
  },
  handlers = {
    lsp.default_setup,
    tsserver = function()
      require('lspconfig').tsserver.setup({
        tsserver_config
      })
    end,
    pylsp = function()
      require('lspconfig').pylsp.setup({
        pylsp_config
      })
    end,
    efm = function()
      require('lspconfig').efm.setup({
        efm_config
      })
    end,
  },
})

--
-- lsp.setup({
--   pylsp = pylsp_config,
--   tsserver = tsserver_config,
--   efm = efm_config,
--   html = {
--     filetypes = { "html", "htmldjango" }, -- Add "django-html" as a recognized filetype
--     settings = {
--       html = {
--         suggest = {
--           -- Add any Django-specific settings here
--           completionItem = {
--             -- Example: trigger completion on "{{" in Django templates
--             triggerCharacters = { "{" },
--           },
--         },
--       },
--     },
--   },
-- })
--
-- require('lspconfig').rust_analyzer.setup {
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- }
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
-- require('lspconfig').pylsp.setup {
--   settings = pylsp_config
-- }
-- require('lspconfig').tsserver.setup(tsserver_config)
-- require('lspconfig').efm.setup(efm_config)
