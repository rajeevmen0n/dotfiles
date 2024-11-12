vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"})

keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = "Clear search highlights"})

keymap.set("n", "<leader>sv", "<C-w>v", {desc = "Split window vertically"})
keymap.set("n", "<leader>sh", "<C-w>s", {desc = "Split window horizontally"})
keymap.set("n", "<leader>se", "<C-w>=", {desc = "Make splits equal size"})
keymap.set("n", "<leader>sx", "<cmd>close<CR>", {desc = "Close current split"})

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", {desc = "Open new tab"})
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", {desc = "Close current tab"})
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", {desc = "Go to next tab"})
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", {desc = "Go to previous tab"})
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", {desc = "Open current buffer in new tab"})

keymap.set("n", "<leader>w", "<cmd>w<CR>", {desc = "Write the whole buffer to the current file"})
keymap.set("n", "<leader>wa", "<cmd>wa<CR>", {desc = "Write all changed buffers"})
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", {desc = "Write the current file and close the window"})
keymap.set("n", "<leader>wqa", "<cmd>wqa<CR>", {desc = "Write all changed buffers and exit vim"})
keymap.set("n", "<leader>q", "<cmd>q<CR>", {desc = "Quit the current window"})
keymap.set("n", "<leader>qi", "<cmd>q!<CR>", {desc = "Quit the current window without writing"})
keymap.set("n", "<leader>qa", "<cmd>qa<CR>", {desc = "Exit vim, unless there are some buffers which have been changed"})
keymap.set("n", "<leader>qai", "<cmd>qa!<CR>", {desc = "Exit vim, all changes are lost"})

keymap.set("n", "<leader>bp", "<cmd>bp<CR>", {desc = "Previous buffer"})
keymap.set("n", "<leader>bn", "<cmd>bn<CR>", {desc = "Next buffer"})
