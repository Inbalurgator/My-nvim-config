--keymaps

local map = vim.keymap

map.set({ "i", "t" }, '<M-i>', '<ESC>')

--yanky

map.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
map.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
map.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
map.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

map.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
map.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
map.set("n", "<C-y>", ":YankyRingHistory<CR>")

--WhichKey

map.set({ "n", "v" }, "<leader>?", ":WhichKey<CR>")

--buffers

-- map.set("n","<M-d>",":bp|bd#<CR>")
-- map.set("n","<M-l>",":bnext<CR>")
-- map.set("n","<M-h>",":bprevious<CR>")
--telescope->yanky
map.set("n", "<leader>fy", ":Telescope yank_history<CR>")
map.set("n", "<leader>fc", ":Telescope catppuccin<CR>")
-- neotree
map.set("n", "<leader><c-t>", ":Neotree dir=")
--WhichKeyDisplay

require("which-key").add({
  { "p",          desc = "Paste (Put after)" },
  { "P",          desc = "Paste (Put before)" },
  { "<c-p>",      desc = "Yanky Ring previous entry" },
  { "<c-n>",      desc = "Yanky Ring next entry" },
  { "<c-y>",      desc = "Yanky Ring history" },
  { "<leader>fy", desc = "Find Yanky Ring" },
  { "<leader>fc", desc = "Find Catppuccin Color" },
  { "<leader><c-t>", desc = "Set Neotree Dir" },
})
