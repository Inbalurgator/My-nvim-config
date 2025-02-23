return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require("astroui.status")
    local utils = require("heirline.utils")
    local ui = require "astroui"
    local config = assert(ui.config.status)
    local getWorkDir = {
      init = function(self)
        self.icon = " "
        local cwd = vim.fn.getcwd(0)
        self.cwd = vim.fn.fnamemodify(cwd, ":~:gs?\\?/?")
      end,
      hl = { fg = "#8aadf4", bold = true },

      flexible = 1,

      {
        -- evaluates to the full-lenth path
        provider = function(self)
          local trail = self.cwd:sub(-1) == "/" and "" or "/"
          return self.icon .. self.cwd .. trail .." "
        end,
      },
      {
        -- evaluates to the shortened path
        provider = function(self)
          local cwd = vim.fn.pathshorten(self.cwd)
          local trail = self.cwd:sub(-1) == "/" and "" or "/"
          return self.icon .. cwd .. trail .. " "
        end,
      },
      {
        -- evaluates to "", hiding the component
        provider = "",
      }
    }
    local anytext = {
      init = function(self)
        self.text = " "
      end,
      {
        provider = function (self)
          return self.text
        end
      }
    }
    local function isTextMode (right)
      local cfg = {
        mode_text = {
          padding =
            {
              left=1,
              right=1
            },
          --[[ str = config.modes[vim.fn.mode(1)][1]  ]]
        },
        hl =
          {
            fg = "#1e1e2e",
            bold = true
          },
      }
      if right then
        table.insert(cfg,{surround={separator = "right"}})
      end
      return cfg
    end

    local function text (txt)
      return {provider = txt}
    end
    local function surround(o,s1,s2)
      s1 = s1 or ""
      s2 = s2 or ""
      return utils.surround({s1,s2},nil,o)
    end
    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(isTextMode(false)),
      status.component.git_branch(),
      status.component.file_info(),
      status.component.git_diff(),
      status.component.builder(getWorkDir),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.nav(),
      status.component.builder(anytext),
      -- status.component.mode({ surround = { separator = "right" } }),
      status.component.mode(isTextMode(true)),
    }
  end
}
