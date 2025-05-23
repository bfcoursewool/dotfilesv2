local builtin = require('telescope.builtin');
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

require('telescope').load_extension('nerdy')
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        -- Tab to select multiple entries and move down
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        -- Shift-Tab to deselect and move up
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
    file_ignore_patterns = { 
      "node_modules",
      "dist",
      "yarn.lock"
    }
  }
}

-- Function to search dotfiles
function SearchDotfiles()
  builtin.find_files({
    prompt_title = "🔍 Search Dotfiles",
    search_dirs = {   -- Set the directory where your dotfiles are located
      "~/.config", 
      "~/.local/bin",
      "~/.aws",
      "~/.ssh",
      "~/.tmux",
      "~/.tmux.conf.local",
      "~/.zshenv",
      "~/.profile",
      "~/.gnupg/gpg.conf",
      "~/.gnupg/gpg-agent.conf",
      "~/.zshrc",
      "~/.mongodb/mongosh/config",
      "~/.mongodb/mongosh/mongosh_repl_history",
      "~/.foundry-bak",
      "~/.foundry",
      "~/.dotfiles",
      "~/.docker",
      "~/.oh-my-zsh",
      "~/.oh-my-zsh/custom", -- totally not sure why this is needed in  addition to the line above, but it works
      "~/.task",
      "~/.zsh_sessions",
      "~/.zsh_history",
      "~/.zprofile",
      "~/.gitconfig",
      "~/.viminfo",
      "~/.kube/config",
      "~/.kube/kubectx",
      "~/.vimrc",
      "~/.taskrc",
      "~/.bash_history",
    },
    hidden = true,  -- Include hidden files (dotfiles)
  })
end

-- Create a user command for convenience
vim.api.nvim_create_user_command('TelescopeDotfiles', SearchDotfiles, {})

