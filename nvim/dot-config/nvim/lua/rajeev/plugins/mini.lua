return {
    {
        "echasnovski/mini.ai",
        version = "*"
    },
    {
        "echasnovski/mini.bufremove",
        version = "*",
        config = function ()
            -- set keymaps
            local mini = require("mini.bufremove")
            vim.keymap.set("n", "<leader>bd", mini.delete, { desc = "Delete buffer" })
        end
    },
}
