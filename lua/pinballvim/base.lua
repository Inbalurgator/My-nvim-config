local opt = vim.opt

opt.cursorline = true --光标提示线
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#323232" })
opt.clipboard:append("unnamedplus")--剪贴板

opt.termguicolors = true

opt.wrap = false
opt.signcolumn="yes"

opt.splitright=true
opt.splitbelow=true

require("telescope").load_extension("yank_history")
require("telescope").load_extension("catppuccin")--telescope->yanky,catppuccin联动
require('catppuccin').setup({
  transparent_background = not vim.g.neovide,
--   -- transparent_background = true,
--   integrations = {
--     cmp = true,
--     gitsigns = true,
--     neotree = true,
--     telescope = true,
--     which_key = true,
--     -- lualine = true,
--   },
})
require("catppuccin").load()
require("lualine").setup()

require('notify').setup({
  background_colour = "#000000",
  -- background_colour = "Normal",
  merge_duplicates = true,
  fps = 60,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "compact",
  stages = "fade_in_slide_out",
  time_formats = {
    notification = "%T",
    notification_history = "%FT%T"
  },
  timeout = 5000,
  top_down = true,
})
