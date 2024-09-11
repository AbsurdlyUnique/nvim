local options = {
    suggestion = {
        enabled = true, -- Enable inline suggestions
        auto_trigger = true, -- Automatically trigger suggestions as you type
        keymap = {
            accept = "<C-a>", -- Accept suggestion with Ctrl + a
            next = "<C-n>",   -- Navigate to the next suggestion
            prev = "<C-p>",   -- Navigate to the previous suggestion
            dismiss = "<C-c>", -- Dismiss the suggestion
        },
    },
    panel = {
        enabled = false, -- Disable the Copilot panel UI
    },
}

return options
