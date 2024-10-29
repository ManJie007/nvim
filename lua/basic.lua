--base vim.o.number = true                 -- 显示行号
vim.o.showmode = true               -- 显示模式
vim.o.showcmd = true                -- 显示部分命令
vim.o.compatible = false            -- 禁用兼容模式
vim.cmd('syntax enable')            -- 启用语法高亮
vim.o.mouse = 'a'                   -- 启用鼠标
vim.o.encoding = 'utf-8'            -- 设置编码
vim.o.termguicolors = true          -- 启用 256 色支持
vim.o.autoindent = true             -- 自动缩进
vim.o.expandtab = true              -- 将 Tab 转为空格
vim.o.softtabstop = 4               -- 插入模式下按一次 Tab 键插入 4 个空格
vim.o.shiftwidth = 4                -- 设置自动缩进为 4 个空格
vim.o.showmatch = true              -- 显示匹配括号
vim.o.hlsearch = true               -- 搜索时高亮
vim.o.incsearch = true              -- 搜索时显示匹配
vim.o.backup = false                -- 不创建备份文件
vim.o.swapfile = false              -- 禁用交换文件
vim.o.autoread = true               -- 文件修改后自动读取
vim.o.wildmenu = true               -- 启用命令行补全菜单
vim.o.wildmode = 'longest:list,full' -- 补全模式
vim.cmd('filetype plugin on')       -- 启用文件类型检测
vim.cmd('filetype indent on')       -- 启用文件类型的缩进
vim.opt.path:append('/usr/include') -- 在路径中添加 /usr/include
vim.o.background = 'dark' -- 配色方案设置
