return {
    "ibhagwan/fzf-lua",
    config = function()
        local fzf = require("fzf-lua")
        local plenary_path = require("plenary.path")
        fzf.setup({})

        -- Gets project paths and finds the common base directory.
        local function get_project_context()
            local project_paths_var = vim.env.NVIM_PROJECT_PATH
            local search_paths = project_paths_var and project_paths_var ~= ""
                and vim.split(project_paths_var, ":")
                or { vim.fn.getcwd() }

            if not search_paths or #search_paths == 0 then return nil, nil end
            if #search_paths == 1 then
                local path = search_paths[1]
                if vim.fn.isdirectory(path) == 1 then
                    return search_paths, path
                else
                    return search_paths, path:match("(.*/)") or path
                end
            end

            local base_parts = vim.split(search_paths[1], "/")
            local common_len = #base_parts

            for i = 2, #search_paths do
                if common_len == 0 then break end
                local current_parts = vim.split(search_paths[i], "/")
                local len = 0
                for j = 1, math.min(common_len, #current_parts) do
                    if base_parts[j] == current_parts[j] then
                        len = len + 1
                    else
                        break
                    end
                end
                common_len = len
            end

            while #base_parts > common_len do
                table.remove(base_parts)
            end

            if #base_parts == 1 and base_parts[1] == "" then
                return search_paths, "/"
            end

            return search_paths, table.concat(base_parts, "/")
        end

        vim.keymap.set("n", "<leader>ff", function()
            local search_paths, base_dir = get_project_context()
            if not search_paths then
                vim.notify("No search paths found.", vim.log.levels.WARN)
                return
            end

            local fd_opts_parts = {}
            table.insert(fd_opts_parts, "--color=never --hidden --type f --type l --exclude .git")
            table.insert(fd_opts_parts, "--base-directory " .. base_dir)
            for _, path in ipairs(search_paths) do
                local relpath = plenary_path:new(path):make_relative(base_dir)
                table.insert(fd_opts_parts, "--search-path " .. vim.fn.shellescape(relpath))
            end

            fzf.files({ cwd = base_dir, cwd_prompt = false, fd_opts = table.concat(fd_opts_parts, " ") })
        end, { desc = "Fzf Files" })

        vim.keymap.set("n", "<leader>fs", function()
            local search_paths, base_dir = get_project_context()
            if not search_paths then
                vim.notify("No search paths found.", vim.log.levels.WARN)
                return
            end

            local escaped_paths = {}
            for _, path in ipairs(search_paths) do
                local relpath = plenary_path:new(path):make_relative(base_dir)
                table.insert(escaped_paths, vim.fn.shellescape(relpath))
            end

            local cmd = string.format(
                "cd %s && echo %s | xargs rg --vimgrep --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
                base_dir,
                table.concat(escaped_paths, " ")
            )
            fzf.live_grep({ cmd = cmd, cwd = base_dir })
        end, { desc = "Fzf live grep" })

        -- Other keymaps
        vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "Fzf Recent files" })
        vim.keymap.set("n", "<leader>fc", fzf.grep_curbuf, { desc = "Fzf find in file" })
        vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Fzf buffers" })
        vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "Fzf keymaps" })
    end,
}
