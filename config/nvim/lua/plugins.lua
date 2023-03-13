local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
		install_path }
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
	autocmd!
	autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	max_job = 24,
	display = {
		open_fn = function()
			return require('packer.util').float { border = "rounded" }
		end,
	},
	git = {
		subcommands = {
			update = "pull --ff-only --progress --rebase=true",
		},
	},
	--profiil = {
	--	enable = true
	--},
	autoremove = false,
}

--  useage
-- use {
--   "myusername/example",        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports "*" for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--   requiring a string which matches one of these patterns, the plugin will be loaded.
-- }

-- Install your plugins here
return packer.startup(function(use)
	-- dependencies
	use "wbthomason/packer.nvim" -- Have packer manage itself
	use "lewis6991/impatient.nvim" -- Speed up loading Lua modules
	use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
	use "nvim-lua/popup.nvim"
	use "rcarriga/nvim-notify" -- notify
	use "kyazdani42/nvim-web-devicons" -- icons

	-- Telescope
	use {
		"nvim-telescope/telescope.nvim",
		requires = "nvim-lua/plenary.nvim"
	}
	use {
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make"
	}
	use "nvim-telescope/telescope-ui-select.nvim"
	use "nvim-telescope/telescope-symbols.nvim"
	use "nvim-telescope/telescope-live-grep-raw.nvim"
	use {
		"tom-anders/telescope-vim-bookmarks.nvim",
		requires = "MattesGroeger/vim-bookmarks"
	}
	use {
		"nvim-telescope/telescope-dap.nvim",
		requires = "mfussenegger/nvim-dap"
	}
	use 'nvim-telescope/telescope-hop.nvim'
	use 'nvim-telescope/telescope-packer.nvim'
	use "LinArcX/telescope-env.nvim"
	--use "nvim-telescope/telescope-file-browser.nvim"

	-- Treesittetr
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate"
	}
	use "nvim-treesitter/nvim-treesitter-refactor"
	use {
		"romgrk/nvim-treesitter-context", -- show class/function at the top
		config = function ()
			require('treesitter-context').setup()
		end
	}
	use "SmiteshP/nvim-gps" -- statusline shows class structure
	use "andymass/vim-matchup" -- highlight, navigate, and operate on sets of matching text
	use 'nvim-treesitter/playground'  -- View treesitter information directly in Neovim

	-- LSP
	use "neovim/nvim-lspconfig" -- enable LSP
	use "williamboman/nvim-lsp-installer" -- simple to use language server installer
	use "kosayoda/nvim-lightbulb" -- code action
	use "ray-x/lsp_signature.nvim" -- show function signature when typing
	use "j-hui/fidget.nvim" -- show lsp progress
	use 'glepnir/lspsaga.nvim'
	-- Debugger
	--use "ravenxrz/DAPInstall.nvim" -- help us install several debuggers
	use {
		"theHamsta/nvim-dap-virtual-text",
		config = function ()
			require('nvim-dap-virtual-text').setup()
		end
	}
	use {
		"rcarriga/nvim-dap-ui",
		requires = {"mfussenegger/nvim-dap"},
		config = function()
			require('dapui').setup()
		end
	}
	use { "jbyuki/one-small-step-for-vimkind", module = "osv" } -- debug any Lua code running in a Neovim instance
	use {
		"williamboman/mason.nvim",
		requires = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-nvim-dap.nvim",
		},
	}

	-- Editor enhance
	-- use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
	use "simrat39/symbols-outline.nvim"
	use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
	use "folke/which-key.nvim" -- which key
	use "ethanholz/nvim-lastplace" -- auto return back to the last modified positon when open a file
	use "nvim-pack/nvim-spectre" -- search and replace pane
	use "tpope/vim-repeat" --  . command enhance
	use "tpope/vim-surround" -- vim surround
	use "akinsho/toggleterm.nvim" -- toggle terminal
	use "lukas-reineke/indent-blankline.nvim" -- indent blankline
	use "phaazon/hop.nvim" -- like easymotion, but more powerful
	use "norcalli/nvim-colorizer.lua" -- show color
	use "sindrets/winshift.nvim" -- rerange window layout
	use "djoshea/vim-autoread" -- like tail -f, but for vim
	use "folke/trouble.nvim" -- better quick fix
	use "RRethy/vim-illuminate" -- highlight undercursor word
	use {
		'francoiscabrol/ranger.vim',
		requires = 'rbgrouleff/bclose.vim',
		config = function()
			vim.g.ranger_replace_netrw = 1
		end
	}

	-- cmp plugins
	use "hrsh7th/nvim-cmp" -- The completion plugin
	use "hrsh7th/cmp-buffer" -- buffer completions
	use "hrsh7th/cmp-path" -- path completions
	use "hrsh7th/cmp-cmdline" -- cmdline completions
	use "petertriho/cmp-git" -- git completions
	use "saadparwaiz1/cmp_luasnip" -- snippet completions
	use "hrsh7th/cmp-nvim-lsp"
	use "hrsh7th/cmp-nvim-lua"
	use "f3fora/cmp-spell" -- spell check
	use "ray-x/cmp-treesitter"

	-- snippets
	use "L3MON4D3/LuaSnip" -- snippet engine
	use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

	-- Git
	use { "lewis6991/gitsigns.nvim",
		event = { "CursorMoved", "CursorMovedI" },
	}

	-- UI
	-- Colorschemes
	use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use "martinsione/darkplus.nvim"
	use 'Mofiqul/dracula.nvim'
	use "navarasu/onedark.nvim"
	use({
		"catppuccin/nvim",
		as = "catppuccin"
	})
	use {
		"projekt0n/github-nvim-theme"
	}
	use "folke/tokyonight.nvim"
	-- better display
	use "yamatsum/nvim-cursorline"
	use "dstein64/nvim-scrollview"
	use "karb94/neoscroll.nvim" -- smart scroll
	use "luukvbaal/stabilize.nvim"
	use "haringsrob/nvim_context_vt" -- show if, for, function... end as virtual text

	-- file explore
	--use "kyazdani42/nvim-tree.lua" -- file explore
	use "akinsho/bufferline.nvim" -- tab
	use "nvim-lualine/lualine.nvim" -- status line

	-- welcome page
	use "goolord/alpha-nvim"

	-- comments
	use "folke/todo-comments.nvim" -- todo-comments
	use "terrortylor/nvim-comment"

	-- tools
	use {
		"skanehira/preview-markdown.vim",
		opt = true,
		cmd = "PreviewMarkdown"
	} -- NOTE:: glow required : https://github.com/charmbracelet/glow
	use "voldikss/vim-translator"
	use "mtdl9/vim-log-highlighting"
	use 'sindrets/diffview.nvim'

	-- code test
	use "vim-test/vim-test"
	use {
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			-- adapters
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-vim-test",
			"nvim-neotest/neotest-plenary",
		}
	}
	use {
		'michaelb/sniprun',
		run = 'bash ./install.sh'
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
