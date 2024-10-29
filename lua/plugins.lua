-- colorscheme
local gruvbox = safe_require('gruvbox')
if gruvbox then
  vim.cmd('colorscheme gruvbox')
end

-- nvim-tree
local nvim_tree = safe_require('nvim-tree')
if nvim_tree then
    nvim_tree.setup({
      renderer = {
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false,
          },
        },
      },
    })
end

-- nvim-treesitter
local nvim_treesitter_configs = safe_require('nvim-treesitter.configs')
if nvim_treesitter_configs then
    nvim_treesitter_configs.setup({
        ensure_installed = { "c", "cpp", "go", "python", "lua", "vim", "vimdoc", "cmake"},
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,               -- 启用 Treesitter 语法高亮
            additional_vim_regex_highlighting = false, -- 避免与正则高亮冲突
        },
        indent = {
            enable = true,               -- 启用基于语法的智能缩进
        },
    })
end
