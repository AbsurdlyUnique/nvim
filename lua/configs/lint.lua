local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
}

lint.linters.luacheck.args = {
    "--globals",
    "vim",
    "--formatter",
    "plain",
    "--codes",
    "--ranges",
    "-",
}

lint.linters.eslint_d = {
    cmd = "eslint_d", -- Command to run eslint_d
    args = {
        "--stdin",
        "--stdin-filename",
        "%filepath",
        "--format",
        "json",
    },
    stream = "stdout",
    ignore_exitcode = true,
    parser = function(output, _)
        local decoded = vim.fn.json_decode(output)
        if not decoded or not decoded[1] or not decoded[1].messages then
            return {}
        end

        local diagnostics = {}
        for _, message in ipairs(decoded[1].messages) do
            table.insert(diagnostics, {
                lnum = message.line - 1,
                col = message.column - 1,
                end_lnum = message.endLine and message.endLine - 1 or message.line - 1,
                end_col = message.endColumn and message.endColumn - 1 or message.column,
                severity = message.severity == 2 and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
                message = message.message,
                source = "eslint_d",
            })
        end

        return diagnostics
    end,
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
