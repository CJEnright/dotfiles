return function()
  local directory = string.format("%s/site/pack/packer/start/", vim.fn.stdpath "data")

  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format("git clone --depth 1 %s %s", "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print "Downloading packer.nvim..."
  vim.cmd "packadd packer.nvim"
end
