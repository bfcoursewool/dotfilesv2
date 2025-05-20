------------------------------------------------------------------------
local overlay = "\u{0336}"        -- combining long stroke overlay U+0336

-- remove existing overlays (helper)
local function remove_strike(text)
  return text:gsub(overlay, "")
end

-- add overlays, but **skip newline characters**
local function add_strike(text)
  text = remove_strike(text)          -- prevent double-overlay
  -- replace every character that is NOT \n or \r
  return text:gsub("[^\n\r]", "%0" .. overlay)
end

-- replace the current visual selection with `new_text`
local function replace_selection(new_text)
  vim.fn.setreg("+", new_text, "c")    -- put text in + register
  vim.cmd('normal! gv"+P')             -- reselect & paste over
end

-- VISUAL-mode mappings -------------------------------------------------
vim.keymap.set("x", "<leader>ks", function()
  -- yank selection into register 0 (linewise or charwise)
  vim.cmd('normal! "0y')
  replace_selection(add_strike(vim.fn.getreg("0")))
end, { desc = "Strike-through selection" })

vim.keymap.set("x", "<leader>kS", function()
  vim.cmd('normal! "0y')
  replace_selection(remove_strike(vim.fn.getreg("0")))
end, { desc = "Remove strike-through" })
------------------------------------------------------------------------

