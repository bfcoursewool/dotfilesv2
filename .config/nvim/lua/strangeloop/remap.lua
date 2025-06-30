-- <leader> is space, cause that makes sense, and also cause Primagen does it.
vim.g.mapleader = " "

-- Not sure how much I will honestly use this but it is pretty sweet to have a toggle-able
-- terminal window that remembers past state, as opposed to using tmux to make a new pane or something
vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>Floaterminal<CR>')

vim.keymap.set('n', '<leader>cc', ':CopilotChatToggle<CR>')
vim.keymap.set('n', '<leader>cm', ':CopilotChatModels<CR>')

-- Harpoon keybindings
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

vim.keymap.set('n', '<c-h>', function() ui.nav_file(1) end)
vim.keymap.set('n', '<C-j>', function() ui.nav_file(2) end)
vim.keymap.set('n', '<C-k>', function() ui.nav_file(3) end)
vim.keymap.set('n', '<C-l>', function() ui.nav_file(4) end)

-- Lazygit via Snacks.nvim is the future of nvim git integration.
vim.keymap.set("n", "<leader>gs", function() Snacks.lazygit() end)
vim.keymap.set("n", "<leader>gb", function() Snacks.git.blame_line() end)
vim.keymap.set("n", "<leader>go", function() Snacks.gitbrowse() end)

-- toggle undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Navigate to dashboard with the quickness...
vim.keymap.set('n', '<leader>d', function()
  Snacks.dashboard()
end)

-- A little finder to select NerdFont icons
vim.keymap.set('n', '<leader>f', ':Telescope nerdy<CR>')

-- jump into a directory view of the parent directory of whatever file you have open at the moment
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { desc = 'Open directory view' })

-- fuzzy find all files, just git files, or do a grep! all with telescope.
local builtin = require('telescope.builtin');
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- The vimgrep version of '<leader>ps'... stores results in the QuickFix list.
-- TODO: It's super slow in nodejs projects... is wildignore (set.lua) set wrong?
vim.keymap.set('n', "<leader>pg", function()
  grepString = vim.fn.input('Vimgrep > ')
  if grepString ~= '' then vim.cmd.vimgrep("/"..grepString.."/ ./**") end
  vim.cmd.copen()
end)

-- Shortcuts for working with the QuickFix list
vim.keymap.set('n', '<leader>q', '<cmd>copen<CR>')
vim.keymap.set('n', '<leader>cq', '<cmd>cclose<CR>')
vim.keymap.set('n', '<leader>rq', function()
  vim.fn.setqflist({}, 'f')
end)
vim.keymap.set('n', '[Q', '<cmd>cfirst<CR>')
vim.keymap.set('n', ']Q', '<cmd>clast<CR>')
vim.keymap.set('n', ']q', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '[q', '<cmd>cprev<CR>zz')

-- lvimgrep shortcut... when you want your vimgrep results to go in the location list
-- instead of the quickfix list
-- TODO: It's super slow in nodejs projects... is wildignore (set.lua) set wrong?
vim.keymap.set('n', "<leader>pl", function()
  grepString = vim.fn.input('LVimgrep > ')
  if grepString ~= '' then vim.cmd.lvimgrep("/"..grepString.."/ ./**") end
  vim.cmd.lopen()
end)

-- Keymaps for working with the location list... open, close, next, prev
vim.keymap.set('n', '<leader>l', '<cmd>lopen<CR>')
vim.keymap.set('n', '<leader>cl', '<cmd>lclose<CR>')
-- Now that I have treesitter-textobjects set up, I'm using [l and ]l to navigate forward and
-- back in the document from loop to loop. I almost never use the location list anyway, so those
-- keymaps are now taking precedence of these, but [L and ]L don't conflict, so I'll just break the
-- pattern of the QF list and buffer list navigation that I have here and use ]L and [L for next/prev
-- in the location list.
vim.keymap.set('n', ']L', '<cmd>lnext<CR>')
vim.keymap.set('n', '[L', '<cmd>lprev<CR>')

-- Similar shortcuts but for buffers. 
vim.keymap.set('n', '<leader>bs', '<cmd>Buffers<CR>') -- buffer (fuzzy) search
vim.keymap.set('n', '<leader>b', function() -- a little custom, less fancy buffer switcher
  vim.cmd.buffers()
  bufNum = vim.fn.input('buffer: ')
  if bufNum ~= '' then vim.cmd.buffer(bufNum) end
end)
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>')
vim.keymap.set('n', '[B', '<cmd>bfirst<CR>')
vim.keymap.set('n', ']B', '<cmd>blast<CR>')
vim.keymap.set('n', ']b', '<cmd>bnext<CR>zz')
vim.keymap.set('n', '[b', '<cmd>bprev<CR>zz')

-- Resize splits easily
vim.keymap.set('n', '<M-h>', '<C-w>5<')
vim.keymap.set('n', '<M-l>', '<C-w>5>')
vim.keymap.set('n', '<M-k>', '<C-w>+5')
vim.keymap.set('n', '<M-j>', '<C-w>-5')
 
-- Navigate to contexts in the barbecue.ui winbar
vim.keymap.set('n', '<leader>bbq', function()
  context = vim.fn.input('Context: ')
  if context ~= '' then require('barbecue.ui').navigate(tonumber(context)) end
end)

-- Something mysterious is superseding the normal C-^ to jump back to the previously
-- used buffer, and I suffered using C-o for a while and then realized I could just 
-- figure out what the underlying command was and map that to something that does work, 
-- and voila. A new era in file navigation is born. Use this. It's fantastic. 
vim.keymap.set('n', '<M-6>', ':b#<CR>')

-- This is one of those things that's cooler on paper than in real life. Use these
-- to move highlighted blocks of text around in visual mode... it even auto-indents them
-- to fit whatever context they get moved into, which is cool. I just never actually use it.
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- concatenate the next line to the end of the current one. Nice. 
vim.keymap.set('n', 'J', 'mzJ`z')

-- Makes the cursor stay vertically centered in the screen while doing half-
-- page jumps, moving through search results, or scrolling by paragraph. 
-- Pretty helpful to feel less disoriented by big jumps.
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')

-- Paste without automatically putting anything which was pasted over into the paste 
-- register, so that whatever you just pasted is still paste-able again. 
vim.keymap.set('x', '<leader>p', '"_dp')

-- Yank into the system paste register instead of vim's paste register. Sweet.
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Do nothing? Cancel anything halfway done? I dunno. Don't use this really. 
vim.keymap.set('n', 'Q', '<nop>')

-- Such a sweet little find and replace for whatever word is under your cursor. 
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- Make the current file executable. 
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true })

-- Little shortcuts for bringing up the most recent Noice notification popup,
-- or seeing the whole history of them for this session. And finally a short-cut
-- for clearing / closing / hiding any currently open notification popups.
vim.keymap.set('n', '<leader>nl', '<cmd>Noice last<CR>')
vim.keymap.set('n', '<leader>nh', '<cmd>Noice history<CR>')
vim.keymap.set('n', '<leader>nx', function() 
  Snacks.notifier.hide() 
end, { desc = 'Hide notifier popups' })

-- Spellcheck stuff...
-- `zg` - add word under cursor to the spellfile
-- `zG` - add the word to the "internal word list"
-- `zug` - remove the word from the spellfile
-- `zuG` - remove from internal word list
-- `zw` - add a word as a "bad" word to the spellfile
-- `zW` - same but for "internal word list"
-- `zuw` - undo / remove a bad word from the spell list
-- `zuW` - same but for internal wordlist
-- `z=` - show and select replacement suggestions
-- `]s` - move to next bad word
-- `[s` - move to previous bad word
-- `:spellr` repeats a spelling replacement for all other matches in the buffer
vim.keymap.set('n', '<leader>zr', ':spellr<CR>')

