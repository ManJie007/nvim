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
