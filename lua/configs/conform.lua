local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        c = { "clang-forrmat" },
        cpp = { "clang-format" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        elixir = { "mix" },
    },

    formatters = {
        ["clang-format"] = {
            prepend_args = {
                "--style=file",
                "--fallback-style=microsoft",
            },
        },
        ["goimports-reviser"] = {
            prepend_args = { "-rm-unused" },
        },
        golines = {
            prepend_args = { "--max-len=80" },
        },
    },

    format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
    },
}

return options
