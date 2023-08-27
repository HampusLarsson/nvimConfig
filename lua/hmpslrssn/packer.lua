
-- Only required if tou have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	--Packer can manage itself
	use 'wbthomason/packer.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'rose-pine/neovim',
		as = 'rose-pine',
	    config = function()
	    	vim.cmd('colorscheme rose-pine')
	    end
	})
	 use{
         'nvim-treesitter/nvim-treesitter',
          run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true})
            ts_update()
            end,}
	 use('nvim-treesitter/playground')
	 use('theprimeagen/harpoon')
	 use('mbbill/undotree')
	 use('tpope/vim-fugitive')
	 use {
		 'VonHeikemen/lsp-zero.nvim',
		 branch = 'v2.x',
		 requires = {
			 -- LSP Support
			 {'neovim/nvim-lspconfig'},             -- Required
			 {'williamboman/mason.nvim',
                opts = {
                    ensure_installed = {
                    'black',
                    'debugpy',
                    'mypy',
                    'ruff',
                    'pyright'
                    },
                },
            },
		     {'williamboman/mason-lspconfig.nvim'}, -- Optional

		 -- Autocompletion
		 {'hrsh7th/nvim-cmp'},     -- Required
		 {'hrsh7th/cmp-nvim-lsp'}, -- Required
		 {'L3MON4D3/LuaSnip'},     -- Required
	     },
     }
     use('jose-elias-alvarez/null-ls.nvim')
     use{'rcarriga/nvim-dap-ui',
        dependencies = 'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end
    }
     use{'mfussenegger/nvim-dap'}
     use{
         'mfussenegger/nvim-dap-python',
         ft = 'python',
         dependencies = {
             {'mfussenegger/nvim-dap'},
             {'rcarriga/nvim-dap-ui'},
         },
         config = function(_, opts)
             local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
             require('dap-python').setup(path)
        end,
    }

end)
