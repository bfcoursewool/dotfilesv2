require("CopilotChat").setup({
  model = "claude-opus-4.8", -- Specify your desired model here
  -- Add other options as needed
  context = 'mcp',
  sticky = {
    '#file:AGENTS.md',
  }
})

-- Auto-save CopilotChat session on exit with timestamp
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if vim.fn.exists(":CopilotChatSave") > 0 then
      local timestamp = os.date("%Y%m%d_%H%M%S")
      local session_name = "session_" .. timestamp
      pcall(vim.cmd, "CopilotChatSave " .. session_name)

      -- CopilotChatSave stores each message's text in a JSON `content` field.
      -- If the last message (the sticky header block) doesn't end in a newline,
      -- the next sticky reference appended on reload gets concatenated onto the
      -- last line (e.g. `...streamTelemetry.ts> ##file://AGENTS.md`). Normalize
      -- every message's content to end with exactly one trailing newline.
      local ok_cfg, config = pcall(require, "CopilotChat.config")
      local history_path = (ok_cfg and config and config.history_path)
          or (vim.fn.stdpath("data") .. "/copilotchat_history")
      local file = vim.fn.expand(history_path) .. "/" .. session_name .. ".json"

      if vim.fn.filereadable(file) == 1 then
        local ok_read, data = pcall(function()
          return vim.fn.json_decode(table.concat(vim.fn.readfile(file), "\n"))
        end)
        if ok_read and type(data) == "table" then
          for _, msg in ipairs(data) do
            if type(msg) == "table" and type(msg.content) == "string" then
              -- Dedupe sticky/context header lines (those beginning with "> ")
              -- that accumulate across load→save cycles. Dedupe on a NORMALIZED
              -- key so the same file collapses even when it appears in different
              -- forms across sessions (resolved `##file://`, `#file:`, or the
              -- `File not found: ...` variant). Preserves first-seen order.
              local function sticky_key(line)
                local body = line:gsub("^>%s*", "")
                body = body:gsub("^File not found:%s*", "")
                body = body:gsub("^##file://", ""):gsub("^#file:", "")
                return (body:gsub("%s+$", ""))
              end

              local seen = {}
              local out = {}
              for line in (msg.content .. "\n"):gmatch("([^\n]*)\n") do
                if line:match("^>%s") then
                  local key = sticky_key(line)
                  if not seen[key] then
                    seen[key] = true
                    table.insert(out, line)
                  end
                else
                  table.insert(out, line)
                end
              end
              msg.content = table.concat(out, "\n"):gsub("%s*$", "") .. "\n"
            end
          end
          pcall(vim.fn.writefile, { vim.fn.json_encode(data) }, file)
        end
      end
    end
  end,
  desc = "Auto-save CopilotChat session on exit with timestamp",
})

-- Clean up old sessions (keep only last 30 days)
local function cleanup_old_sessions()
  local session_dir = vim.fn.stdpath("data") .. "/copilotchat_history"
  if vim.fn.isdirectory(session_dir) == 1 then
    local files = vim.fn.globpath(session_dir, "session_*.json", false, true)
    local cutoff_time = os.time() - (30 * 24 * 60 * 60) -- 30 days
    for _, file in ipairs(files) do
      local mtime = vim.fn.getftime(file)
      if mtime < cutoff_time then
        vim.fn.delete(file)
      end
    end
  end
end

-- Run cleanup on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = cleanup_old_sessions,
  desc = "Cleanup old CopilotChat sessions",
})
