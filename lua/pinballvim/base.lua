local opt = vim.opt

vim.cmd.colorscheme "catppuccin-macchiato"
-- opt.shell = "powershell"
-- opt.shell = "pwsh"
-- opt.shellcmdflag = "/c nu"

opt.cursorline = true --光标提示线
opt.clipboard:append("unnamedplus")--剪贴板

opt.termguicolors = true

opt.wrap = false
opt.signcolumn="yes"

opt.splitright=true
opt.splitbelow=true

vim.g.transparency = 0.8 --透明度

require("telescope").load_extension("yank_history")
require("telescope").load_extension("catppuccin")--telescope->yanky,catppuccin联动
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
