-- The idea here was to have a function that returns a random cmd for the dashboard header
-- so I'd get a different one each time I launch vim, but it's not working, so this will
-- just sit here until I figure it out, but also it is a nice little collection of demo 
-- cmds that you can potentially use to get your sweet ASCII art header... Between 
-- ASCII-image-converter, chafa, and lolcat, you can do some pretty fun stuff. 
local function fetch_random_header()
  local strings = {
    '~/.config/nvim/animate-rainbow-header.sh ~/.config/nvim/assets/ascii-wolfy-thrack.txt',
    '~/.config/nvim/animate-rainbow-header.sh ~/.config/nvim/assets/chafa-header.txt',
    'chafa --size=100x30 /Users/robertkotz/.config/nvim/assets/final-header.png',
    'cat ~/.config/nvim/assets/ascii-wolfy-thrack.txt',
    'ascii-image-converter -d 100,30 -C ~/.config/nvim/assets/final-header.png | lolcat -F 0.3',
  }
  local random_index = math.random(1, #strings)
  return strings[random_index]
end

require('lazy').setup({
  checker = {
    enabled = true
  },
  -- Snacks is a snazzy new set of plugins from folke. This sets up a sick dashboard
  -- and also turns on/configures the notifier, though I'm not honestly sure how exactly 
  -- to make the best use of it just yet.
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {

      -- Dashboard stuff... shortcut functions, recent projects, recent files, open PRs
      dashboard = {
        width = 100,
        sections = {
          {
            section = 'terminal',
            align = 'center',
            cmd = '~/.config/nvim/animate-rainbow-header.sh ~/.config/nvim/assets/ascii-wolfy-thrack.txt',
            height = 30,
            width = 100,
            padding = 1,
          },
          {
            align = 'center',
            padding = 1,
            text = {
              { '  Update[u] ', hl = 'Label' },
              { '  Files[f] ', hl = 'DiagnosticInfo' },
              { '  Apps[a] ', hl = 'DiagnosticInfo' },
              { '  Dotfiles[d] ', hl = 'DiagnosticInfo' },
              { '  Check Health[h] ', hl = '@property' },
              { '  Last Session[l] ', hl = 'Number' },
              { '  Quit NeoVim[q] ', hl = '@string' },
            },
          },
          { section = 'startup', padding = 1 },
          { icon = '󰏓 ', title = 'Projects', limit=5, section = 'projects', indent = 2, padding = 1 },
          { icon = ' ', title = 'Recent Files', limit=8, section = 'recent_files', indent = 2, padding = 1 },
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local cmds = {
              {
                icon = " ",
                title = "Open PRs",
                cmd = "gh pr list -L 3",
                height = 7,
              },
            }
            return vim.tbl_map(function(cmd)
              return vim.tbl_extend("force", {
                section = "terminal",
                enabled = in_git,
                align='center',
                indent = 2,
                padding = 1,
                ttl = 5 * 60,
              }, cmd)
            end, cmds)
          end,
          { text = '', action = ':Lazy update', key = 'u' },
          { text = '', action = ':Telescope find_files', key = 'f' },
          { text = '', action = ':Telescope builtin', key = 'a' },
          { text = '', action = ':TelescopeDotfiles', key = 'd' },
          { text = '', action = ':checkhealth', key = 'h' },
          { text = '', action = ':SessionRestore', key = 'l' },
          { text = '', action = ':qa', key = 'q' },
        },
      },

      -- Notifier settings. There's an autocommand set up which links the LSP loading state info to the notifier as well.
      notify = { enabled = true },
      notifier = {
        timeout = 3000, -- default timeout in ms
        width = { min = 40, max = 0.4 },
        height = { min = 1, max = 0.6 },
        -- editor margin to keep free. tabline and statusline are taken into account automatically
        margin = { top = 0, right = 1, bottom = 0 },
        padding = true, -- add 1 cell of left/right padding to the notification window
        sort = { "level", "added" }, -- sort by level and time
        -- minimum log level to display. TRACE is the lowest
        -- all notifications are stored in history
        level = vim.log.levels.TRACE,
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          debug = " ",
          trace = " ",
        },
        keep = function(notif)
          return vim.fn.getcmdpos() > 0
        end,
        ---@type snacks.notifier.style
        style = "compact",
        top_down = true, -- place notifications from top to bottom
        date_format = "%R", -- time format for notifications
        -- format for footer when more lines are available
        -- %d is replaced with the number of lines.
        -- only works for styles with a border
        ---@type string|boolean
        more_format = " ↓ %d lines ",
        refresh = 50, -- refresh at most every 50ms
      },

      -- lazygit integration is dope. 
      lazygit = {
        -- automatically configure lazygit to use the current colorscheme
        -- and integrate edit with the current neovim instance
        configure = true,
        -- extra configuration for lazygit that will be merged with the default
        -- snacks does NOT have a full yaml parser, so if you need "test" to appear with the quotes
        -- you need to double quote it: "\"test\""
        config = {
          os = { editPreset = "nvim-remote" },
          gui = {
            -- set to an empty string "" to disable icons
            nerdFontsVersion = "3",
          },
        },
        theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
        -- Theme for lazygit
        theme = {
          [241]                      = { fg = "Special" },
          activeBorderColor          = { fg = "MatchParen", bold = true },
          cherryPickedCommitBgColor  = { fg = "Identifier" },
          cherryPickedCommitFgColor  = { fg = "Function" },
          defaultFgColor             = { fg = "Normal" },
          inactiveBorderColor        = { fg = "FloatBorder" },
          optionsTextColor           = { fg = "Function" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor        = { bg = "Visual" }, -- set to default to have no background colour
          unstagedChangesColor       = { fg = "DiagnosticError" },
        },
        win = {
          style = "lazygit",
        },
      },

      -- This is what makes <leader>go work in nvim. Lets you open the file you're looking at in nvim, but in a browser,
      -- using whatever git hosting service your repo uses (ie, github, gitlab, bitbucket).
      gitbrowse = {
        ---@class snacks.gitbrowse.Config
        ---@field url_patterns? table<string, table<string, string|fun(fields:snacks.gitbrowse.Fields):string>>
        notify = true, -- show notification on open
        -- Handler to open the url in a browser
        ---@param url string
        open = function(url)
          if vim.fn.has("nvim-0.10") == 0 then
            require("lazy.util").open(url, { system = true })
            return
          end
          vim.ui.open(url)
        end,
        ---@type "repo" | "branch" | "file" | "commit"
        what = "file", -- what to open. not all remotes support all types
        branch = nil, ---@type string?
        line_start = nil, ---@type number?
        line_end = nil, ---@type number?
        -- patterns to transform remotes to an actual URL
        remote_patterns = {
          { "^(https?://.*)%.git$"              , "%1" },
          { "^git@(.+):(.+)%.git$"              , "https://%1/%2" },
          { "^git@(.+):(.+)$"                   , "https://%1/%2" },
          { "^git@(.+)/(.+)$"                   , "https://%1/%2" },
          { "^ssh://git@(.*)$"                  , "https://%1" },
          { "^ssh://([^:/]+)(:%d+)/(.*)$"       , "https://%1/%3" },
          { "^ssh://([^/]+)/(.*)$"              , "https://%1/%2" },
          { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
          { "^https://%w*@(.*)"                 , "https://%1" },
          { "^git@(.*)"                         , "https://%1" },
          { ":%d+"                              , "" },
          { "%.git$"                            , "" },
        },
        url_patterns = {
          ["github%.com"] = {
            branch = "/tree/{branch}",
            file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
            commit = "/commit/{commit}",
          },
          ["gitlab%.com"] = {
            branch = "/-/tree/{branch}",
            file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
            commit = "/-/commit/{commit}",
          },
          ["bitbucket%.org"] = {
            branch = "/src/{branch}",
            file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
            commit = "/commits/{commit}",
          },
        },
      },
    }
  },

  -- gnupg integration for when you need to do s00per s3kr37 stuff.
  { 'jamessan/vim-gnupg' },

  -- A really versatile fuzzy finder that has lots of neat builtin functions
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Find icons from the nerd font that's installed
  {
    '2kabhishek/nerdy.nvim',
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Nerdy',
  },

  -- A nice autocomplete plugin
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = {},
        },
        ghost_text = { enabled = false }, -- Disable ghost text for performance
      },
    },
    opts_extend = { "sources.default" },
    config = function(_, opts)
      require('blink.cmp').setup(opts)
      -- Optimize buffer leave behavior
      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function()
          require('blink.cmp').hide()
        end,
      })
    end,
  },

  -- Surround arbitrary selections with an arbitrary character, function, or html tag!
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        surrounds = {
          c = {
            add = function()
              return { { "/* " }, { " */" } }
            end,
            find = "/%*.-%*/",
            delete = "^(/* )().-( */)$",
          },
        },
      })
    end
  },

  -- Trying out leap.nvim... just gives a nice consolidated method for leaping
  -- to specific locations in a file, sort of consolidating fFtT, /, ?, hjkl, etc.
  -- into a single search interface.
  {
    'ggandor/leap.nvim',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
      leap.opts.case_sensitive = true
    end
  },

  -- Copilot chat gives a nice little Cursor-style interface to chat with an LLM within a coding session. 
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        build = "npm install -g mcp-hub@latest",
        config = function()
          require('strangeloop.mcphub')
        end
      },
    },
    config = function()
      require('strangeloop.CopilotChat')
    end,
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      window = {
        layout = 'vertical',
        width = 0.40,
      },
    },
  },

  -- Adds character highlighting for fFtT so you can see at a glance which 
  -- character of each word is unique and can act as a search target for that
  -- line. Pretty nifty.
  {
    'jinh0/eyeliner.nvim',
    config = function()
      require'eyeliner'.setup {
        -- show highlights only after keypress
        highlight_on_key = true,
        -- dim all other characters if set to true (recommended!)
        dim = true,            
        -- set the maximum number of characters eyeliner.nvim will check from
        -- your current cursor position; this is useful if you are dealing with
        -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
        max_length = 9999,
        -- filetypes for which eyeliner should be disabled;
        -- e.g., to disable on help files:
        -- disabled_filetypes = {"help"}
        disabled_filetypes = {},
        -- buftypes for which eyeliner should be disabled
        -- e.g., disabled_buftypes = {"nofile"}
        disabled_buftypes = {},
        -- add eyeliner to f/F/t/T keymaps;
        -- see section on advanced configuration for more information
        default_keymaps = true,
      }
    end
  },

  -- Treesitter stuff... this gives us syntax highlighting and some fancy custom
  -- text objects. There's a treesitter.lua file in the plugins "after" directory
  -- that has additional configs to be aware of. 
  'nvim-treesitter/nvim-treesitter-context',
  {
  	'nvim-treesitter/nvim-treesitter',
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  	config = function ()
  		require 'nvim-treesitter.install'.compilers = { "clang" }
  	end,
    opts = {
      auto_install = true
    },
	  build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
  },
  'nvim-treesitter/playground',

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

              ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
          },

          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
              ["]="] = { query = "@assignment.outer", desc = "Next assignment start" },

              -- You can pass a query group to use query from queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's locals.scm and folds.scm. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              -- This one conflicts with a remap that takes me to the containing context, and since I don't currently
              -- work with a lot of code that uses classes, I'm choosing to sacrifice this previous class motion so I can
              -- hold onto the "go to context" motion I already have and am used to.
              -- ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
              ["[="] = { query = "@assignment.outer", desc = "Previous assignment start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
        },
      })

      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

      -- So if you use one of the goto_next_start/goto_next_end/etc. options above, you might want to continue
      -- iterating through the matches, like with `n/N` for search or `;/,` for fFtT motions... I couldn't manage
      -- to figure out a way to use `;/,` with these, which I would have preferred, so instead we have `'/"` for next/
      -- prev match when searching using these custom goto_next/goto_previous things.
      local function repeat_and_center(forward)
        return function()
          local ok = forward and ts_repeat_move.repeat_last_move()
          or ts_repeat_move.repeat_last_move_opposite()
          if ok then                      -- only center if we really jumped
            vim.cmd("normal! zz")
          end
        end
      end

      vim.keymap.set({ "n", "x", "o" }, "'", repeat_and_center(true),
        { silent = true, desc = "repeat TS move forward + zz" })

      vim.keymap.set({ "n", "x", "o" }, '"', repeat_and_center(false),
        { silent = true, desc = "repeat TS move backward + zz" })
    end
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },

  -- Color codes nested delimiters for easier readability
  'HiPhish/rainbow-delimiters.nvim',

  -- A UI Component library for nvim, used by noice.nvim
  'MunifTanjim/nui.nvim',

  -- Makes a nice little visually centered popup window bar thing for entering `:<Command>` type things, for 
  -- grepping, etc. Just a UI nicety, really. 
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper module="..." entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   nvim-notify is only needed, if you want to use the notification view.
      --   If not available, we use mini as the fallback
      "rcarriga/nvim-notify",
    }
  },

  -- A replacement for netrw... this is basically a file management tool that lets you manipulate the filesystem
  -- like a regular text buffer. It's super cool and good.
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    config = function()
      require('oil').setup({
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits=true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
        win_options = {
          wrap = true
        },
        keymaps = {
          ['gt'] = 'actions.toggle_trash'
        }
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },

  -- BBQ provides a VSCode-style "winbar" at the top of a window that shows
  -- context info pulled from the LSP. There are some remaps set up in remap.lua
  -- that allow you to jump to contexts easily. The contexts are also clickable, if
  -- you ever wanted to commit the sin of using a mouse in vim.
  {
    "utilyre/barbecue.nvim",
    branch = "main",
    name = "barbecue",
    -- version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
      attach_navic = false,
      show_modified = false,
    },
  },

  -- A nice little statusline plugin that I like.
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- Fuzzy-finder but for your buffers
  'junegunn/fzf',
  'junegunn/fzf.vim',

  -- "harpoon" your top few files for instant access switching between them
  'theprimeagen/harpoon',

  -- Get this: it's an undo tree.
  {
    'mbbill/undotree',
  },

   -- Language Server Protocol client! All kinds of wizardry available from this sucker. 
   {
	   'VonHeikemen/lsp-zero.nvim',
	   branch = 'v3.x',
	   dependencies = {
	 	  {'williamboman/mason.nvim'},
	 	  {'williamboman/mason-lspconfig.nvim'},
	 	  {'neovim/nvim-lspconfig'},
	 	  --{'hrsh7th/nvim-cmp'},
	 	  --{'hrsh7th/cmp-nvim-lsp'},
	 	  {'L3MON4D3/LuaSnip'},
	   }
   },

  -- Nobody wants ugly code. 
  {
    'prettier/vim-prettier',
    build = "yarn install --frozen-lockfile --production",
    ft = {
      'javascript',
      'typescript',
      'typescriptreact',
      'css',
      'json',
      'lua',
      'yaml',
      'less',
      'scss',
      'graphql',
      'vue',
      'html'
    }
  },

  -- Auto-session will automatically save my sessions, and then
  -- gives me a handy dandy SessionRestore command that I can hook
  -- up with the Snacks.nvim dashboard plugin to reload everything on restart!
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup({
        auto_restore = false,
        auto_save = true,
        save_extra_commands = {},
        suppressed_dirs = { '~/', '~/Downloads/', '/tmp' },
      })
    end
  },

  -- Markdown renderer... nice. 
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
      { 'nvim-treesitter' }
    },
    config = function()
      require('render-markdown').setup({})
    end,
  },

  -- Fancy icons! Gotta have a NerdFont installed for this one to work. 
  'nvim-tree/nvim-web-devicons',

  -- Buncha different colorschemes I tried out. 
  -- I don't think I actually need all these installed though, given telescope has a "colorscheme" builtin,
  -- and the fzf plugin also provides a ":Colors" command to easily try out / change to other color schemes. 
  { 'folke/tokyonight.nvim', lazy = true },
  { 'rose-pine/neovim', lazy = true },
  { 'rebelot/kanagawa.nvim', lazy = true },
  { 'scottmckendry/cyberdream.nvim', lazy = true },
  { 'olimorris/onedarkpro.nvim', lazy = true },
  { 'catppuccin/nvim', name = 'catppuccin', lazy = 'true' },
  { 'oxfist/night-owl.nvim', lazy = true },
  { 'kvrohit/substrata.nvim', lazy = true},
  { 'Mofiqul/vscode.nvim', lazy = true },
  {
    'bluz71/vim-moonfly-colors',
    name = 'moonfly',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme('moonfly')
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end,
  },

})

