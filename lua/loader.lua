--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path})
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup({
  function(use)
    use 'wbthomason/packer.nvim' -- packer can manage itself

    -- Treesitter interface
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
        require('nvim-treesitter.install').update({
          with_sync = true
        })
      end
    }

    -- LSP - Quickstart configs for Nvim LSP
    use {'neovim/nvim-lspconfig'}
    -- Mason
    -- Portable package manager for Neovim that runs everywhere Neovim runs.
    -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    use {'williamboman/mason.nvim'}
    use {'williamboman/mason-lspconfig.nvim'}

    -- Color schemes
    -- Rose-pine - Soho vibes for Neovim
    use {
      'rose-pine/neovim',
      as = 'rose-pine'
    }
    -- Tokyonight - A clean, dark Neovim theme written in Lua, with support for lsp,
    -- treesitter and lots of plugins. Includes additional themes for Kitty, Alacritty, iTerm and Fish.
    use 'folke/tokyonight.nvim'
    -- Github - Github's Neovim themes
    use 'projekt0n/github-nvim-theme'

    -- Statusline
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    use { 'nvim-lualine/lualine.nvim' }

    -- File explore
    -- nvim-tree.lua - A file explorer tree for neovim written in lua
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons',
        opt = true
      }
    }

    -- Autopairs
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup {}
      end
    }

    -- Autocomplete
    -- A completion plugin for neovim coded in Lua.
    use {
      'hrsh7th/nvim-cmp',
      requires = {'L3MON4D3/LuaSnip', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip'}
    }

    -- LSP Progress lualine componenet
    use 'arkav/lualine-lsp-progress'

    -- Smart and powerful comment plugin for neovim.
    -- Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
    use 'numToStr/Comment.nvim'

    -- Git integration for buffers
    use 'lewis6991/gitsigns.nvim'

    -- Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- Telescope
    -- Find, Filter, Preview, Pick. All lua, all the time.
    use {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = {'nvim-lua/plenary.nvim'}
    }
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      requires = {'nvim-telescope/telescope.nvim'}
    }

    use 'navarasu/onedark.nvim' -- theme

    use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        -- you can configure Hop the way you like here; see :h hop-config
        require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      end
    }

    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}

    use 'windwp/nvim-ts-autotag'

    use "nvim-tree/nvim-web-devicons"
    use {
      'goolord/alpha-nvim',
      requires = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
      end
    }

    use 'MattesGroeger/vim-bookmarks'
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    use 'MunifTanjim/nui.nvim'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({
          border = 'single'
        })
      end
    },
    profile = {
      enable = false
    }
  }
})
