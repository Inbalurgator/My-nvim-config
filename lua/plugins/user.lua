vim.g.nvim_transparent = false
local function file(name)
  local fid = io.open(name, "r")
  if fid ~= nil then
    io.close(fid)
    return true
  else
    return false
  end
end

return {

  {
    "xiyaowong/nvim-transparent",
    name = vim.g.neovide and "nvim-transparent(disable for neovide)" and "nvim-transparent",
    enabled = not vim.g.neovide,
    priority = 999,
    lazy = true,
    event = { "VeryLazy", "BufEnter" },
    opts = {
      extra_groups = {
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeCursorLine",
        "lualine_*",
        "",
      },
      exclude_groups = {
        "BufferLine*",
      },
    },
    keys = {
      { "<leader>uT", "<cmd>TransparentToggle<cr>", desc = "Toggle Transparent" },
    },
    config = function(_, opts)
      vim.g.nvim_transparent = true
      local transparent_cache = vim.fn.stdpath "data" .. "/transparent_cache"
      if not file(transparent_cache) then
        local f = io.open(transparent_cache, "w")
        f:write "true"
        f:close()
      end
      if not vim.g.neovide then require("transparent").setup(opts) end
    end,
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = { ---@class snacks.dashboard.Config
        ---@field enabled? boolean
        ---@field sections snacks.dashboard.Section
        ---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
        enabled = true,
        width = 60,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        pane_gap = 4, -- empty columns between vertical panes
        autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
        -- These settings are used by some built-in sections
        preset = {
          -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
          ---@type fun(cmd:string, opts:table)|nil
          pick = nil,
          -- Used by the `keys` section to show keymaps.
          -- Set your custom keymaps here.
          -- When using a function, the `items` argument are the default keymaps.
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            -- { icon = "󰢱 ", key = "M", desc = "Mason", action = ":Mason", enabled = package.loaded.mason ~= nil },
            { icon = "󰢱 ", key = "M", desc = "Mason", action = ":Mason", enabled = true },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          -- Used by the `header` section
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
        -- item field formatters
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function() return Snacks.git.get_root() ~= nil end,
            -- enabled = true,
            cmd = "git status --short --branch --renames",
            height = 12,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
      -- explorer = { enabled = true },
      -- indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      -- notifier = { enabled = true },
      -- quickfile = { enabled = true },
      -- scope = { enabled = true },
      -- scroll = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- words = { enabled = true },
    },
  },

  { --██
    "goolord/alpha-nvim",
    enabled = false,
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "         ██████████████        ",
        "       ██              ██      ",
        "     ██                  ██    ",
        "   ██                      ██  ",
        " ██                          ██",
        " ██            █             ██",
        " ██          █████           ██",
        " ██        █████████         ██",
        " ██          █████           ██",
        " ██            █             ██",
        " ██                          ██",
        "   ██                      ██  ",
        "     ██                  ██    ",
        "       ██              ██      ",
        "         ██████████████        ",
      }
      return opts
    end,
  },

  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = {
      -- fuzzy.implementation = 'prefer_rust' | 'lua',
      fuzzy = { implementation = "lua" },
      keymap = { preset = "super-tab" },
      cmdline = {
        enabled = false,
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        menu = { border = "single" },
        documentation = { window = { border = "single" } },
      },
      signature = { window = { border = "single" } },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "nvim-telescope/telescope.nvim",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      require("telescope").load_extension "catppuccin"
      require("telescope").load_extension "yank_history"
    end,
  },

  {
    "backwardspy/telescope-catppuccin.nvim",
    name = "telescope-catppuccin",
    priority = 1000,
    opt = {},
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true, -- INFO: You can let colorscheme plugin lazy
    key = { --because 99.99% of them can auto listen to event colorscheme
      { "<leader>fc", "<cmd>Telescope catppuccin<CR>", "n", desc = "Find catppuccin colors" },
    },
  },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    opts = {},
  },

  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = true,
    priority = 1000,
  },

  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    opts = {
      {
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
          inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 10, -- amount of lines we will try to show around the current line
        treesitter = true, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      },
    },
    keys = {
      { "<leader><leader>t", "<cmd>Twilight<CR>", "n", desc = "Twilight" },
    },
  },

  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 3, -- turn off the statusline in zen mode
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        todo = { enabled = false }, -- if set to "true", todo-comments.nvim highlights will be disabled
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
        -- this will change the scale factor in Neovide when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        neovide = {
          enabled = true,
          -- Will multiply the current scale factor by this number
          scale = 1.2,
          -- disable the Neovide animations while in Zen mode
          -- disable_animations = {
          -- neovide_animation_length = 0,
          -- neovide_cursor_animate_command_line = false,
          -- neovide_scroll_animation_length = 0,
          -- neovide_position_animation_length = 0,
          -- neovide_cursor_animation_length = 0,
          -- neovide_cursor_vfx_mode = "",
          -- },
          disable_animations = false,
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win) end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function() end,
    },
    keys = {
      { "<leader><leader>z", "<cmd>ZenMode<CR>", "n", desc = "Zen mode" },
    },
  },

  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- i disable some keymap here
        n = {
          ["<Leader>bp"] = false,
          ["<Leader>br"] = false,
          ["<Leader>bl"] = false,
          ["<Leader>bd"] = { desc = "Delete buffers" },
          ["<leader>h"] = { "", desc = "󱐋 Advanced flash" },
          ["<leader>s"] = { desc = "[ Surround" },
          ["<Leader>fT"] = {
            "<cmd>TodoTelescope<CR>",
            desc = "Find Todos(snacks picker hasnt be released yet...)",
          },
          -- ["<leader>sa"] = {
          --   "<Plug>(nvim-surround-normal)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Add surround (normal)",
          -- },
          -- ["<leader>ss"] = {
          --   "<Plug>(nvim-surround-normal-cur)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Add surround (cursorline)",
          -- },
          -- ["<leader>sA"] = {
          --   "<Plug>(nvim-surround-normal-line)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Add surround (normal-New line)",
          -- },
          -- ["<leader>sS"] = {
          --   "<Plug>(nvim-surround-normal-cur-line)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Add surround (cursorline-New line)",
          -- },
          -- ["<leader>sd"] = {
          --   "<Plug>(nvim-surround-delete)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Delete surround",
          -- },
          -- ["<leader>sc"] = {
          --   "<Plug>(nvim-surround-change)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Change surround",
          -- },
          -- ["<leader>sC"] = {
          --   "<Plug>(nvim-surround-change-line)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Change surround(line)",
          -- },
        },
        i = {
          ["ii"] = { "<ESC>", desc = "Exit mode" },
          ["<c-v>"] = { "<C-r>+", desc = "Paste", noremap = true, silent = true },
          -- ["<c-c>c"] = { "<Esc>yyl<ins>", desc = "Paste", noremap = true, silent = true },
        },
        v = {
          -- ["<leader>s"] = { desc = "[ Surround" },
          -- ["<leader>sa"] = {
          --   "<Plug>(nvim-surround-visual)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Add surround (Visual)",
          -- },
          -- ["<leader>ss"] = {
          --   "<Plug>(nvim-surround-visual-line)",
          --   noremap = true,
          --   silent = true,
          --   desc = "Add surround (Visual-New line)",
          -- },
        },
        t = {
          ["<M-i>"] = { "<ESC>", desc = "Exit mode" },
        },
        x = {
          ["<leader>h"] = { desc = "󱐋 Advanced flash" },
        },
        o = {
          ["<leader>h"] = { desc = "󱐋 Advanced flash" },
        },
      },
    },
  },

  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      formatting = {
        timeout_ms = 90000,
      },
      file_operations = {
        timeout = 90000,
      },
    },
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    enabled = false,
    event = "VeryLazy",
    config = function(_, opts)
      require("nvim-surround").setup {
        keymaps = {
          insert = false,
          insert_line = false,
          normal = false,
          normal_cur = false,
          normal_line = false,
          normal_cur_line = false,
          visual = false,
          visual_line = false,
          delete = false,
          change = false,
          change_line = false,
        },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    requires = { "nvim-tree/nvim-web-devicons", opt = true },
    -- lazy = true,
    -- event = "User Astrofile",
    -- setup = {
    --   require("lualine").setup()
    -- },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        -- theme = "codedark",
        component_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = false,
        globalstatus = true,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    version = false,
    -- enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- { "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { "<leader><c-t>", mode = { "n" }, ":Neotree dir=", desc = "Set neotree dir" },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      prompt = {
        enabled = true,
        prefix = { { " ", "FlashPromptIcon" } },
        win_config = {
          relative = "editor",
          width = 1, -- when <=1 it's a percentage of the editor width
          height = 1,
          row = -1, -- when negative it's an offset from the bottom
          col = 0, -- when negative it's an offset from the right
          zindex = 1000,
        },
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      {
        "<leader>hl",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump {
            search = { mode = "search", max_length = 0 },
            label = { after = { 0, 0 } },
            pattern = "^",
          }
        end,
        desc = "Flash to any line",
      },
      {
        "<leader>hw",
        mode = { "n", "x", "o" },
        function()
          local Flash = require "flash"

          ---@param opts Flash.Format
          local function format(opts)
            -- always show first and second label
            return {
              { opts.match.label1, "FlashMatch" },
              { opts.match.label2, "FlashLabel" },
            }
          end
          Flash.jump {
            search = { mode = "search" },
            label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
            pattern = [[\<]],
            action = function(match, state)
              state:hide()
              Flash.jump {
                search = { max_length = 0 },
                highlight = { matches = false },
                label = { format = format },
                matcher = function(win)
                  -- limit matches to the current label
                  return vim.tbl_filter(function(m) return m.label == match.label and m.win == win end, state.results)
                end,
                labeler = function(matches)
                  for _, m in ipairs(matches) do
                    m.label = m.label2 -- use the second label
                  end
                end,
              }
            end,
            labeler = function(matches, state)
              local labels = state:labels()
              for m, match in ipairs(matches) do
                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                match.label2 = labels[(m - 1) % #labels + 1]
                match.label = match.label1
              end
            end,
          }
        end, --this part is from examples
        desc = "2Word Flash word",
      },
      {
        "<leader>hh",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump {
            pattern = ".", -- initialize pattern with any char
            search = {
              mode = function(pattern)
                -- remove leading dot
                if pattern:sub(1, 1) == "." then pattern = pattern:sub(2) end
                -- return word pattern and proper skip pattern
                return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
              end,
            },
            -- select the range
            -- jump = { pos = "range" },
          }
        end,
        desc = "Flash word",
      },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    lazy = true,
    event = "BufEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        -- separator_style = "slope",
        show_buffer_close_icons = false,
        show_close_icon = false,
        tab_size = 12,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },
      },
    },
    keys = { -- use the community config : https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/bars-and-lines/bufferline-nvim/init.lua
      --   { "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Pick buffer" },
      --   { "<leader>bn", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      --   { "<leader>bp", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
      --   { "<leader>bdh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close buffer on the left" },
      --   { "<leader>bdl", "<cmd>BufferLineCloseRight<CR>", desc = "Close buffer on the right" },
      --   { "<leader>bdo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffer(not current)" },
      --   { "<leader>bdb", "<cmd>BufferLinePickClose<CR>", desc = "Pick to close" },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- require("bufferline.groups").builtin.pinned:with { icon = " " }
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>tg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 0,
    },
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "a", mode = { "n", "v" } },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = true } end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<leader><leader>l",
        function() require("which-key").show { global = false } end,
        desc = "Buffer Local Keymaps (which-key)",
      },
      {
        "<leader><leader>?",
        function() require("which-key").show { loop = true } end,
        desc = "Buffer Keymaps (Hydra mode)",
      },
    },
  },

  {
    "karb94/neoscroll.nvim",
    -- enabled = not vim.g.neovide,
    event = "VeryLazy",
    opts = {
      mappings = vim.g.neovide and {} or { -- if i use the mappings for neovide some of the cursor movement will be very crazy
        "<C-u>",
        "<C-d>",
        "<C-b>",
        "<C-f>",
        "<C-y>",
        "<C-e>",
        "zt",
        "zz",
        "zb",
      },
      -- keep keybind at a inital status if not neovide
      -- so that also <c-d><c-u> can work with the autocmd below
      -- that autocmd let you auto zz and if it is neovide it use zz from vim
      -- else from neoscroll
      hide_cursor = not vim.g.neovide,
      easing = "quadratic",
      duration_multiplier = vim.g.neovide and 0 or 1,
    },
    config = function(_, opts)
      local neoscroll = require "neoscroll"
      neoscroll.setup(opts)
      if false then
        vim.api.nvim_create_autocmd("CursorMoved", {
          callback = function()
            if vim.bo.buftype == "nofile" or vim.g.scroller then
            else
              if vim.g.neovide then
                vim.cmd "normal! zz"
              else
                neoscroll.zz { half_win_duration = 250 }
              end
            end
          end,
        })
      end
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline",
        -- view="cmdline_popup"
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      background_colour = vim.g.nvim_transparent and "Normal" or "#949cbb",
      merge_duplicates = true,
      fps = 60,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      stages = "slide",
      time_formats = {
        notification = "%T",
        notification_history = "%FT%T",
      },
      timeout = 5000,
      top_down = true,
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        "lwc_ls",
        "ast_grep",
        "biome",
        -- "clang_format",
        -- "json_lsp",
        -- "prettier",
        -- "stylua",
        "ts_ls",
        -- add more arguments for adding more language servers
      },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = false,
    lazy = true,
    opts = {
      open_mapping = [[<c-t>]],
      direction = "float",
      shell = "nu",
    },
    keys = {
      { "<c-t>", desc = "ToggleTerm" },
    },
  },

  {
    "gbprod/yanky.nvim",
    lazy = true,
    -- event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      { "p", "<Plug>(YankyPutAfter)", { "n", "x" }, desc = "Paste (Put after)" },
      { "P", "<Plug>(YankyPutBefore)", { "n", "x" }, desc = "Paste (Put before)" },
      { "gp", "<Plug>(YankyGPutAfter)", { "n", "x" }, desc = "Paste (Put after)" },
      { "gP", "<Plug>(YankyGPutBefore)", { "n", "x" }, desc = "Paste (Put before)" },
      { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Yanky Ring previous entry" },
      { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Yanky Ring next entry" },
      { "<c-y>", "<cmd>YankyRingHistory<CR>", desc = "Yanky Ring history" },
      -- { "<leader>fy", "<cmd>Telescope yank_history<CR>", { silent = true, desc = "Find Yanky Ring" } },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      -- opts variable is the default configuration table for the setup function call
      local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      -- Only insert new sources, do not replace the existing ones
      -- (If you wish to replace, use `opts.sources = {}` instead of the `list_insert_unique` function)
      opts.sources = require("astrocore").list_insert_unique(opts.sources, {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.biome,
      })
    end,
  },
}
