require("CopilotChat").setup({
  model = "claude-sonnet-4.5",  -- Specify your desired model here
  -- Add other options as needed
  context = 'mcp',
})

-- Auto-save CopilotChat session on exit with timestamp
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if vim.fn.exists(":CopilotChatSave") > 0 then
      local timestamp = os.date("%Y%m%d_%H%M%S")
      local session_name = "session_" .. timestamp
      -- Use pcall to prevent errors from stopping the shutdown
      pcall(vim.cmd, "CopilotChatSave " .. session_name)
    end
  end,
  desc = "Auto-save CopilotChat session on exit with timestamp",
})

-- Clean up old sessions (keep only last 30 days)
local function cleanup_old_sessions()
  local session_dir = vim.fn.stdpath("data") .. "/copilotchat/chats"
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
