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
        ensure_installed = { "c", "cpp", "go", "python", "lua", "vim", "vimdoc", "cmake" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,                             -- 启用 Treesitter 语法高亮
            additional_vim_regex_highlighting = false, -- 避免与正则高亮冲突
        },
        indent = {
            enable = true, -- 启用基于语法的智能缩进
        },
    })
end

-- nvim-lspconfig
local lspconfig = safe_require('lspconfig')
if lspconfig then
    -- 定义 on_attach 函数
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true }

      -- 定义一个函数来为缓冲区设置按键映射
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

      -- 常用 LSP 快捷键映射
      buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)        -- 跳转到定义
      buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)       -- 跳转到声明
      buf_set_keymap("n", "gi", "<Cmd>lua vim.lsp.buf.implementation()<CR>", opts)    -- 跳转到实现
      buf_set_keymap("n", "gr", "<Cmd>lua vim.lsp.buf.references()<CR>", opts)        -- 查找引用
      buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)              -- 显示悬停文档
      buf_set_keymap("n", "<C-k>", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", opts) -- 显示函数签名
      buf_set_keymap("n", "<leader>rn", "<Cmd>lua vim.lsp.buf.rename()<CR>", opts)    -- 重命名符号
      buf_set_keymap("n", "<leader>ca", "<Cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- 显示代码操作
      buf_set_keymap("n", "[d", "<Cmd>lua vim.diagnostic.goto_prev()<CR>", opts)      -- 跳转到上一个诊断
      buf_set_keymap("n", "]d", "<Cmd>lua vim.diagnostic.goto_next()<CR>", opts)      -- 跳转到下一个诊断
      buf_set_keymap("n", "<leader>fm", "<Cmd>lua vim.lsp.buf.format{ async = true }<CR>", opts) -- 格式化
    end
    lspconfig.pyright.setup {
        on_attach = on_attach,
    }
    lspconfig.clangd.setup {
        on_attach = on_attach,
    }
    lspconfig.lua_ls.setup {
        on_attach = on_attach,
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
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

-- nvim-cmp
local cmp = safe_require('cmp')
if cmp then
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = 'buffer' },
        })
    })

    -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
    -- Set configuration for specific filetype.
    --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]] --

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
    })

    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    require('lspconfig')['clangd'].setup {
        capabilities = capabilities
    }
    require('lspconfig')['pyright'].setup {
        capabilities = capabilities
    }
    require('lspconfig')['lua_ls'].setup {
        capabilities = capabilities
    }
end

-- toggleterm
local toggleterm = safe_require("toggleterm")
if toggleterm then
    toggleterm.setup({
        open_mapping = [[<leader>t]],
        direction = 'float',
    })
end
