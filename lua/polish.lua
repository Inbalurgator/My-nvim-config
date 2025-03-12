local status = vim.g
local opt = vim.opt
-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
-- vim.filetype.add {
--   extension = {
--     foo = "fooscript",
--   },
--   filename = {
--     ["Foofile"] = "fooscript",
--   },
--   pattern = {
--     ["~/%.config/foo/.*"] = "fooscript",
--   },
-- }

if vim.g.neovide then
  --字体已经设置过了
  status.neovide_confirm_quit = true --退出确认
  status.neovide_fullscreen = false --全屏！！！
  status.neovide_remember_window_size = true --记住窗口大小，但是为什么这个也要设置啊（
  status.neovide_cursor_vfx_mode = "railgun" --释放一串完美的轨道炮特效
  status.neovide_cursor_trail_size = 0.9 --0.8
  -- status.neovide_cursor_vfx_particle_density = 48
  -- status.neovide_cursor_vfx_particle_phase = 0
  -- status.neovide_transparency = 0.9 --neovide透明度,独立
  status.neovide_cursor_smooth_blink = true
  vim.g.neovide_title_background_color =
    string.format("%x", vim.api.nvim_get_hl(0, { id = vim.api.nvim_get_hl_id_by_name "Normal" }).bg)
  --ime part
  local function set_ime(args)
    if args.event:match "Enter$" then
      vim.g.neovide_input_ime = true
    else
      vim.g.neovide_input_ime = false
    end
  end

  local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

  vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    group = ime_input,
    pattern = "*",
    callback = set_ime,
  })

  vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
    group = ime_input,
    pattern = "[/\\?]",
    callback = set_ime,
  })
end

local function is_good_buffer(table)
  for k, v in pairs(table) do
    if v == vim.bo.buftype then return true end
  end
  return false
end
-- vim.api.nvim_create_autocmd("CursorMoved", {
--   callback = function()
--     if vim.bo.buftype == "nofile" then
--     else
--       if vim.g.neovide then
--         vim.cmd "normal! zz"
--       else
--         neoscroll.zz()
--       end
--     end
--   end,
-- })

if not vim.g.vscode then
  require("lspconfig").biome.setup {}
  -- vim.api.nvim_create_autocmd("BufRead", {
  --   callback = function() vim.cmd "TwilightEnable" end,
  -- })
end
opt.cursorline = true --光标提示线
opt.clipboard:append "unnamedplus" --剪贴板

opt.termguicolors = true

opt.wrap = false
opt.foldcolumn = "0"
opt.signcolumn = "yes"

opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 999
