local config = {}

config["catppuccin"] = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  -- lazy = true,
  opt = {
    transparent_background = not vim.g.neovide,
    -- transparent_background = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      neotree = true,
      telescope = true,
      which_key = true,
      -- lualine = true,
    },
  },
  -- setup = {
  --   require("catppuccin").load()
  -- },
}

require("catppuccin")

return{}
