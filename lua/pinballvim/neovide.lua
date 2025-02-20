local status = vim.g

if vim.g.neovide then
  --字体已经设置过了
  status.neovide_no_idle = true --没有空闲
  status.neovide_confirm_quit = true --退出确认
  status.neovide_fullscreen = false --全屏！！！
  status.neovide_remember_window_size = true --记住窗口大小，但是为什么这个也要设置啊（
  status.neovide_cursor_vfx_mode = "railgun" --释放一串完美的轨道炮特效
  status.neovide_cursor_trail_size = 0.9 --0.8
  -- status.neovide_cursor_vfx_particle_density = 48
  -- status.neovide_cursor_vfx_particle_phase = 0
  status.neovide_transparency = 0.9 --neovide透明度,独立
end
