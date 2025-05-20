-- Turning on Lua module cache to hopefully speed up start-up time
if vim.loader then vim.loader.enable() end

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("strangeloop.lazy")
require("strangeloop.remap")
require("strangeloop.set")
require('strangeloop.autocommands')
require('strangeloop.strikethrough')
require('strangeloop.luasnip')
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})

vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#800080" })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#7700FF" })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = "#00FFFF" })

vim.g.fugitive_diff_command = 'delta --paging=never'
vim.env.GIT_PAGER = 'delta'

