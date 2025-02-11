return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function ()

        -- mini.bufremove
        local bufremove = require('mini.bufremove')
        vim.keymap.set('n', '<leader>bx', bufremove.delete, { desc = 'Close buffer' })

        -- mini.files
        local files = require('mini.files')
        files.setup()
        local minifiles_toggle = function(...)
            if not MiniFiles.close() then MiniFiles.open(...) end
        end
        vim.keymap.set('n', '<leader>e', minifiles_toggle, { desc = 'Open file explorer' })

        -- mini.hipatterns
        local hipatterns = require('mini.hipatterns')
        hipatterns.setup({
            highlighters = {
                -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
                fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
                hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
                todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
                note  = { pattern = '%f[%w]()OTE()%f[%W]',  group = 'MiniHipatternsNote'  },

                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })

        -- mini.misc
        local misc = require('mini.misc')
        misc.setup()
        vim.keymap.set('n', '<leader>sm', misc.zoom, { desc = 'Maximize/minimize a split' })

        -- plugins without any setup
        require('mini.ai').setup()
        require('mini.comment').setup()
        require('mini.icons').setup()
        require('mini.indentscope').setup()
        require('mini.operators').setup()
        require('mini.pairs').setup()
        require('mini.starter').setup()
        require('mini.statusline').setup()
        require('mini.surround').setup()
        require('mini.tabline').setup()
        require('mini.bracketed').setup()

    end
}
