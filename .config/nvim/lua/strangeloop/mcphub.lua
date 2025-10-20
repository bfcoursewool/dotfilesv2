require("mcphub").setup({
  extensions = {
    copilotchat = {
      enabled = true,
      convert_tools_to_functions = true,     -- Convert MCP tools to CopilotChat functions
      convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions  
      add_mcp_prefix = false,                -- Add "mcp_" prefix to function names
    }
  },
  global_env = {
    BRAVE_API_KEY = os.getenv('BRAVE_API_KEY'),
    DEFAULT_MINIMUM_TOKENS = os.getenv('DEFAULT_MINIMUM_TOKENS'),
  },
  log = {
    level = 4,
    to_file = true,
  },
  log_file = "/tmp/mcphub.log",  -- Uncomment to enable file logging
})
