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
require('strangeloop.CopilotChat')
require('strangeloop.mcphub')
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/LuaSnip/"})

local neoscroll = require('neoscroll')
local keymap = {
  ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
  ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
  ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end;
  ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end;
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
  ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end;
  ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end;
  ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end;
}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end

vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = "#800080" })
vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = "#7700FF" })
vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = "#00FFFF" })

vim.g.fugitive_diff_command = 'delta --paging=never'
vim.env.GIT_PAGER = 'delta'

