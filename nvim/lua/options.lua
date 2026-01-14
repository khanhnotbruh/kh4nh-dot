vim.opt.nu=true
vim.opt.relativenumber=true

vim.opt.tabstop = 4

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab =true

vim.opt.smartindent=true

vim.opt.wrap=false

vim.opt.swapfile=false
vim.opt.backup=false
vim.opt.undodir=os.getenv("HOME") .. "/.vim/undodir"  --uncomment this on linux--
vim.opt.undofile=true

vim.g.mapleader=" "

vim.opt.hlsearch=false
vim.opt.incsearch=true

vim.opt.termguicolors=true

vim.opt.scrolloff=16

vim.opt.updatetime=50

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- if you hate mouse ,uncomment this
vim.o.mouse="a"
