return {
    "rmagatti/auto-session",
    config = function()
        local auto_session = require("auto-session")

        auto_session.setup({
            auto_save = true,
            auto_restore = true,
            suppressed_dirs = {"~/", "~/Downloads", "~/Documents", "~/Desktop/", "~/tmp", "/tmp"},
            post_restore_cmds = {
                function()
                    -- Re-attach treesitter to current buffer after session restore
                    vim.cmd('silent! edit')
                end
            },
        })

        local keymap = vim.keymap
        keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", {desc = "Restore session for cwd"}) -- restore last workspace session for current directory
        keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", {desc = "Save session for auto session root dir"}) -- save workspace session for current working directory
    end
}

