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

-- nvim-lspconfig
local lspconfig = safe_require('lspconfig')
if lspconfig then
    lspconfig.pyright.setup{}
    lspconfig.clangd.setup{}
    lspconfig.lua_ls.setup {
        on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file("", true)
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }
end
