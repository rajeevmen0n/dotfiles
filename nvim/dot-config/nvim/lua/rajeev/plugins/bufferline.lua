return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
        options = {
            mode = "tabs",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "NvimTree",
                    highlight = "Directory",
                    separator = true
                }
            }
        },
    },
}
