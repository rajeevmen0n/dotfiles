return {
    "ibhagwan/fzf-lua",
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({})

        -- keymaps
        vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Fzf Files" })
        vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Fzf Recent files" })
        vim.keymap.set("n", "<leader>fc", fzf.grep_curbuf, { desc = "Fzf find in file" })
        vim.keymap.set("n", "<leader>fs", fzf.live_grep, { desc = "Fzf live grep" })
        vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf buffers" })
        vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Fzf keymaps" })
    end
}
