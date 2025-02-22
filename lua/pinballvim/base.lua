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
  integrations = {
    cmp = true,
    gitsigns = true,
    neotree = true,
    telescope = true,
    which_key = true,
    -- lualine = true,
  },
})

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
require('nvim-cursorline').setup {
  cursorline = {
    enable = false,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  }
}
--[[require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}) ]]
