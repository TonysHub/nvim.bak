local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "isort", "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    javascript = { { "prettierd", "prettier" } },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    svelte = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    graphql = { "prettier" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
    async = true,
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
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

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  nmap('<leader>f', function() conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 }) end, '[F]ormat')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')


  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end

-- mason requires this order of setup
require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- rust_analyzer = {},
  tsserver = {
    settings = {
      formatting = true,
      formatoptions = {
        tabSize = 2,
        useTabs = false,
      },
    }
  },
  efm = {
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
  },
  html = {
    filetypes = { "html", "htmldjango" }, -- Add "django-html" as a recognized filetype
    settings = {
      html = {
        suggest = {
          -- Add any Django-specific settings here
          completionItem = {
            -- Example: trigger completion on "{{" in Django templates
            triggerCharacters = { "{{" },
          },
        },
      },
    },
  },
  pylsp = {
    filetypes = { 'python' },
    settings = {
      pylsp = {
        plugins = {
          -- formatter options
          mccabe = { enabled = true, threshold = 20 },
          black = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          -- linter options
          pylint = { enabled = false, executable = "pylint" },
          pyflakes = { enabled = false },
          pycodestyle = { enabled = true, ignore = { "E501" } },
          flake8 = { enabled = true, ignore = { "E501" } },
        }
      }
    }
  },
  lua_ls = {
    filetypes = { 'lua' },
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        diagnostics = { disable = { 'missing-fields' } },
      }
    }
  }
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}


mason_lspconfig.setup_handlers {
  require('lspconfig').efm.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers.efm.settings,
    filetypes = servers.efm.filetypes,
  },
  require('lspconfig').html.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers.html.settings,
    filetypes = servers.html.filetypes,
  },
  require('lspconfig').lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers.lua_ls.settings,
    filetypes = servers.lua_ls.filetypes,
  },
  require('lspconfig').pylsp.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers.pylsp.settings,
    filetypes = servers.pylsp.filetypes,
  },
  require('lspconfig').tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers.tsserver.settings,
  },
}
