local config = {}

if true then return {} end

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
  --   require.load
  -- },
}

config["alpha-nvim"] = { --██
  "goolord/alpha-nvim",
  opts = function(_, opts)
    -- customize the dashboard header
    opts.section.header.val = {
      "         ██████████████         ",
      "       ██              ██           ",
      "     ██                  ██         ",
      "   ██                      ██       ",
      " ██                          ██     ",
      " ██            █             ██     ",
      " ██          █████           ██     ",
      " ██        █████████         ██     ",
      " ██          █████           ██     ",
      " ██            █             ██     ",
      " ██                          ██     ",
      "   ██                      ██       ",
      "     ██                  ██         ",
      "       ██              ██           ",
      "         ██████████████         ",
    }
    return opts
  end,
}
-- require("catppuccin")

return config
