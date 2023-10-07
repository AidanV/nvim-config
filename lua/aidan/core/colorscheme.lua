local status, _ = pcall(vim.cmd, "colorscheme rose-pine")
if not status then
  print("colorscheme not found!")
  return
end
