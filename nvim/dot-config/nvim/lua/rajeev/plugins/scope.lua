return {
    "tiagovla/scope.nvim",
    config = function ()
        vim.opt.sessionoptions = {
            "buffers",
            "tabpages",
            "globals",
        }
        require("scope").setup({})
    end
}
