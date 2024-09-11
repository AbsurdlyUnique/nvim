-- load defaults i.e lua_lsp
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- list of all servers configured.
lspconfig.servers = {
    "lua_ls",
    "clangd",
    "gopls",
    "ts_ls",
    "intelephense",
    "phpactor",
    "elixirls",
}

-- list of servers configured with default config.
local default_servers = {}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end

lspconfig.cmake.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})

lspconfig.clangd.setup({

    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        client.server_capabilities.signatureHelpProvider = false
        on_attach(client)
    end,
    on_init = on_init,
    capabilities = capabilities,
})

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})

lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gotmpl", "gowork" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
        },
    },
})

lspconfig.ts_ls.setup({
    on_attach = function(client, bufnr)
        -- Disable formatting, as we will use prettier for that.
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
})

lspconfig.intelephense.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = {
        intelephense = {
            -- Add your Intelephense license key here
            licenceKey = "00Q84A6JU550R9J",
        },
    },
})

lspconfig.phpactor.setup({
    on_attach = function(client, bufnr)
        -- Enable code actions with keybinding
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        local opts = { noremap = true, silent = true }
        on_attach(client, bufnr)
    end,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "phpactor", "language-server" }, -- Command to start PHPActor
    filetypes = { "php" }, -- Activate only for PHP files
    root_dir = lspconfig.util.root_pattern("composer.json", ".git"), -- Set the root of the project
})

lspconfig.elixirls.setup({
    cmd = { "elixir-ls" },
    on_attach = on_attach,
    on_init = on_init,
    settings = {
        elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
        },
    },
    capabilities = capabilities,
    filetypes = { "elixir", "eelixir", "heex", "surface", "ex", "exs" },
    root_dir = lspconfig.util.root_pattern("mix.exs", ".git"),
})
