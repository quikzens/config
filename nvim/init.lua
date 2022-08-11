vim.opt.compatible = false
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false 
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.encoding="utf-8"

vim.g.mapleader = ','
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 15

-- Keymap {{

local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')
key_mapper('i', 'jk', '<ESC>')
key_mapper('n', '<leader>w', '<cmd>write<cr>')
key_mapper('n', '<leader>q', ':wq<cr>')
key_mapper('n', '<leader>d', ':Lexplore<cr>')

-- }}


-- Plugins {{

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

require('packer').startup(function(use)
	-- Package manager
	use 'wbthomason/packer.nvim'

	-- Theme inspired by Atom
  use 'joshdick/onedark.vim'

  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  return
end

-- }}


-- Plugins Configuration {{

-- 'joshdick/onedark.vim'
vim.cmd('colorscheme onedark')

-- }}
