--- This LspProgress autocommand is for hooking up the snacks.nvim notifier to report on 
--- lsp loading progress.
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})

---- Function to ensure exactly one newline at EOF
--local function clean_trailing_newlines()
--  local last_non_blank = vim.fn.prevnonblank(vim.fn.line('$')) -- Find the last non-blank line
--  if last_non_blank == 0 then
--    return -- If the file is empty, do nothing
--  end
--
--  -- Delete all lines after the last non-blank line
--  vim.api.nvim_buf_set_lines(0, last_non_blank, -1, false, { "" })
--end

---- Autocommand to trigger on BufWritePre (before saving the file), 
--vim.api.nvim_create_autocmd("BufWritePre", {
--  group = vim.api.nvim_create_augroup("TrimTrailingNewlines", { clear = true }),
--  pattern = "*", -- Apply to all filetypes
--  callback = clean_trailing_newlines
--})

