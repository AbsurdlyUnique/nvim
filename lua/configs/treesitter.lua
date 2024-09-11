local options = {
    ensure_installed = {
        "bash",
        "c",
        "cmake",
        "cpp",
        "make",
        "fish",
        "lua",
        "luadoc",
        "markdown",
        "printf",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "php",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "elixir",
        "heex",
        "eex",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },
    auto_install = true,
}

require("nvim-treesitter.configs").setup(options)
