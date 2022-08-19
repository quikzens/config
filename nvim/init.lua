-- Options {{
vim.opt.compatible = false
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = false 
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.encoding = "utf-8"
vim.opt.swapfile = false
vim.opt.splitright = true
-- }}


-- Global {{
vim.g.mapleader = ','
-- }}


-- Keymap {{
local key_mapper = function(mode, key, result)
  vim.api.nvim_set_keymap(
    mode,
    key,
    result,
    {noremap = true, silent = true}
  )
end

-- no arrow keys to move my cursor in normal mode
-- it forces me to use 'hjkl' keys
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')

key_mapper('i', 'jk', '<ESC>') -- easier to get out from 'Insert' mode

key_mapper('n', '<leader>s', ':w<cr>') -- save file
key_mapper('n', '<leader>q', ':q<cr>') -- quit file
key_mapper('n', '<leader>w', ':wq<cr>') -- save & quit file
key_mapper('n', '<leader>a', ':q!<cr>') -- abort (quit without save) file
key_mapper('n', '<leader>e', ':NvimTreeToggle<cr>') -- toggle nvim-tree file explorer

key_mapper('n', '<leader>t', ':BufferPick<cr>')

-- swap paste command for more convenient use 
-- initially 'p' paste text at the front of the cursor, i want it the other way around
key_mapper('n', 'p', 'P')
key_mapper('n', 'P', 'p')

key_mapper('v', 'y', '"+y') -- automatically yank/copy selected text to clipboard

key_mapper('n', 'gg', 'gg0')
key_mapper('n', 'G', 'G$')

-- for easier buffers navigation
key_mapper('n', '[b', ':bprevious<cr>')
key_mapper('n', ']b', ':bnext<cr>')
key_mapper('n', '[B', ':bfirst<cr>')
key_mapper('n', ']B', ':blast<cr>')

key_mapper('', '<leader>h', ':wincmd h<cr>')
key_mapper('', '<leader>l', ':wincmd l<cr>')
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

	-- Status Line
	use 'nvim-lualine/lualine.nvim'

	-- Go
	use { "fatih/vim-go", run = ':GoUpdateBinaries' }

	-- Development
	use "SirVer/ultisnips"
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', 
		},
	}
	use {
		'romgrk/barbar.nvim',
		requires = {'kyazdani42/nvim-web-devicons'}
	}

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

-- 'SirVer/ultisnips'
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpForwardTrigger = "<c-b>"

-- netrw plugin settings
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 15
vim.g.netrw_liststyle = 3 

-- 'kyazdani42/nvim-tree.lua'
require("nvim-tree").setup()

-- 'romgrk/barbar.nvim'
require'bufferline'.setup {
  -- Enable/disable animations
  animation = true,

  -- Enable/disable auto-hiding the tab bar when there is a single buffer
  auto_hide = false,

  -- Enable/disable current/total tabpages indicator (top right corner)
  tabpages = true,

  -- Enable/disable close button
  closable = false,

  -- Enables/disable clickable tabs
  --  - left-click: go to buffer
  --  - middle-click: delete buffer
  clickable = true,

  -- Excludes buffers from the tabline
  exclude_ft = {'javascript'},
  exclude_name = {'package.json'},

  -- Enable/disable icons
  -- if set to 'numbers', will show buffer index in the tabline
  -- if set to 'both', will show buffer index and icons in the tabline
	icons = false,

  -- If set, the icon color will follow its corresponding buffer
  -- highlight group. By default, the Buffer*Icon group is linked to the
  -- Buffer* group (see Highlighting below). Otherwise, it will take its
  -- default value as defined by devicons.
  icon_custom_colors = false,

  -- Configure icons on the bufferline.
  icon_separator_active = '▎',
  icon_separator_inactive = '▎',
  icon_close_tab = '',
  icon_close_tab_modified = '●',
  icon_pinned = '車',

  -- If true, new buffers will be inserted at the start/end of the list.
  -- Default is to insert after current buffer.
  insert_at_end = false,
  insert_at_start = false,

  -- Sets the maximum padding width with which to surround each tab
  maximum_padding = 1,

  -- Sets the maximum buffer name length.
  maximum_length = 30,

  -- If set, the letters for each buffer in buffer-pick mode will be
  -- assigned based on their name. Otherwise or in case all letters are
  -- already assigned, the behavior is to assign letters in order of
  -- usability (see order below)
  semantic_letters = true,

  -- New buffer letters are assigned in this order. This order is
  -- optimal for the qwerty keyboard layout but might need adjustement
  -- for other layouts.
  letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',

  -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
  -- where X is the buffer number. But only a static string is accepted here.
  no_name_title = nil,
}

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

local function get_tree_size()
  return require'nvim-tree.view'.View.width
end

nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('Resize', function()
  bufferline_state.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_state.set_offset(0)
end)

-- 'nvim-lualine/lualine.nvim'
require('lualine').setup {
	options = {
    icons_enabled = true,
    theme = 'auto',
	  component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
-- }}

