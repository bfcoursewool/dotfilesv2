-- <leader> is space, cause that makes sense, and also cause Primagen does it.
vim.g.mapleader = " "

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

-- Resize splits easily
vim.keymap.set('n', '<M-h>', '<C-w>5<')
vim.keymap.set('n', '<M-l>', '<C-w>5>')
vim.keymap.set('n', '<M-k>', '<C-w>+5')
vim.keymap.set('n', '<M-j>', '<C-w>-5')

-- Yank into the system paste register instead of vim's paste register. Sweet.
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Such a sweet little find and replace for whatever word is under your cursor.
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

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
