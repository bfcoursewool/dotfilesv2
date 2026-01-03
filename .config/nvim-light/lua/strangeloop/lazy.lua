require('lazy').setup({
  checker = {
    enabled = true
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

  -- Smooth scrolling for various motions like ctrl-d/ctrl-u and other big vertical jumps
  {
    "karb94/neoscroll.nvim",
    opts = {},
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

  -- Adds character highlighting for fFtT so you can see at a glance which
  -- character of each word is unique and can act as a search target for that
  -- line. Pretty nifty.
  {
    'jinh0/eyeliner.nvim',
    config = function()
      require 'eyeliner'.setup {
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

  -- Get this: it's an undo tree.
  {
    'mbbill/undotree',
  },

  -- Buncha different colorschemes I tried out.
  -- I don't think I actually need all these installed though, given telescope has a "colorscheme" builtin,
  -- and the fzf plugin also provides a ":Colors" command to easily try out / change to other color schemes.
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
