vim.g.copilot_enabled   = 1        -- keep plugin running for chat
vim.g.copilot_no_tab_map = true    -- don’t remap Tab
vim.g.copilot_assume_mapped = true -- stop “no mapping found” warnings

-- optional: disable auto suggestions completely
vim.g.copilot_filetypes = { ["*"] = false }
-- … then re‑enable per filetype when you really want it:
-- vim.cmd("Copilot enable") or :Copilot enable

require("strangeloop")
