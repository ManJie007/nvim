local keymaps = {}

-- custom
-- leader 
vim.g.mapleader = ','

-- 在插入模式下按 'jk' 退出插入模式
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Ctrl + s 保存当前文件
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- 在普通模式下按 ';' 进入命令行模式
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true, silent = true })

-- 类似于 unimpaired.vim 的快捷键
vim.api.nvim_set_keymap('n', '[b', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']b', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[t', ':tprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']t', ':tnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })

-- 智能窗口切换
vim.api.nvim_set_keymap('n', '<C-j>', '<C-W>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-W>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-W>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-W>l', { noremap = true, silent = true })


-- 将 <leader>n 映射到 :NvimTreeToggle
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

return keymaps
