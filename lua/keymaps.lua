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

-- telescope
local builtin = safe_require('telescope.builtin')
if builtin then
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>ft', builtin.tags, { desc = 'Telescope tags' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope lsp_references' })
    vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = 'Telescope lsp_document_symbols' })
    vim.keymap.set('n', '<leader>lgs', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope lsp_dynamic_workspace_symbols' })
end

-- 在终端模式下将 <Esc> 映射为 <C-\><C-n>，这样可以直接返回普通模式
vim.api.nvim_create_autocmd("TermEnter", {
  pattern = "*",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
  end,
})

return keymaps
