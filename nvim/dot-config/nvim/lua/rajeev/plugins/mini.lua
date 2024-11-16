return {
    'echasnovski/mini.nvim',
    version = '*',
    config = function ()

        -- mini.bufremove
        local bufremove = require('mini.bufremove')
        vim.keymap.set('n', '<leader>bd', bufremove.delete, { desc = 'Delete buffer' })

        -- mini.clue
        local miniclue = require('mini.clue')
        miniclue.setup({
            triggers = {
                -- Leader triggers
                { mode = 'n', keys = '<Leader>' },
                { mode = 'x', keys = '<Leader>' },

                -- Built-in completion
                { mode = 'i', keys = '<C-x>' },

                -- `g` key
                { mode = 'n', keys = 'g' },
                { mode = 'x', keys = 'g' },

                -- Marks
                { mode = 'n', keys = "'" },
                { mode = 'n', keys = '`' },
                { mode = 'x', keys = "'" },
                { mode = 'x', keys = '`' },

                -- Registers
                { mode = 'n', keys = '"' },
                { mode = 'x', keys = '"' },
                { mode = 'i', keys = '<C-r>' },
                { mode = 'c', keys = '<C-r>' },

                -- Window commands
                { mode = 'n', keys = '<C-w>' },

                -- `z` key
                { mode = 'n', keys = 'z' },
                { mode = 'x', keys = 'z' },
            },
            clues = {
                -- Enhance this by adding descriptions for <Leader> mapping groups
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
        })

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

    end
}
