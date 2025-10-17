vim.opt.nu = true
vim.opt.relativenumber = true 

vim.opt.splitright = true

vim.opt.spell = true
vim.opt.spelllang = en_us

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir/"
vim.opt.undofile = true

vim.opt.wildignore = "**/node_modules/**,**/dist/**,./.git/**"

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes" 
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.fixendofline = true

vim.g.mapleader = " "

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.opt.exrc = true
vim.opt.secure = true

--vim.opt_local.errorformat = "%f(%l\\,%c): %t%*[^:]: %m"
--vim.opt_local.makeprg = [[cd modules/server && yarn tsc --noEmit 2>&1 \| sed 's\|^\|modules/server/\|']]

