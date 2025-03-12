local shada_dir = vim.fn.stdpath "state" .. "/shada/"
local tmp_files = vim.fn.glob(shada_dir .. "main.shada.tmp.*")

for tmp_file in string.gmatch(tmp_files, "[^\n]+") do
  os.remove(tmp_file)
  print("Deleted temporary file: " .. tmp_file)
end

return {}
