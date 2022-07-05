--
-- ╭─────────────╮
-- │ Plugins.lua │
-- ╰─────────────╯
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ Plugins.lua is the configuration file that imports necessary plugins.        │
-- │ It also links the configuration files of plugins respectively.               │
-- │  - {@link plug} contains the list of imported VimPlug plugins.               │
-- │  - {@link nvim-treesitter.configs} contains treesitter language support list.│
-- │  - {@link coc_global_extensions} includes Conqueror of Completions(CoC)      │
-- │  related configurations.                                                     │
-- │  - {@link sniprun} contains snippet runner configurations                    │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- @author umutsevdi

-- VimPlug Plugins
vim.cmd([[
call plug#begin()
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
    Plug 'junegunn/vim-easy-align'                                                           " Auto align
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'                                      " Snippet support
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }                        " FZF
    Plug 'ryanoasis/vim-devicons'                                                            " Vim NerdFont icons
    Plug 'preservim/nerdtree'                                                                " NERDTree is the file tree on right
    Plug 'nvim-lua/plenary.nvim'                                                             " Telescope requires this package
    Plug 'nvim-telescope/telescope.nvim'                                                     " Telescope is a FZF extension that displays preview
    Plug 'nvim-lualine/lualine.nvim'                                                         " Lualine is the bar on the bottom that displays variues elements
    Plug 'glepnir/dashboard-nvim'                                                                " Start page
    Plug 'tpope/vim-fugitive'                                                                " Git Integration
    Plug 'gitgutter/Vim'                                                                     " Displays git diff
    Plug 'preservim/tagbar'                                                                  " Tag bar displays functions, classes and variables of files on the left 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}                              " Syntax highlighting 
    Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}          " Conqueror of Completions: Language server for any language
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }                                       " Go official vim plugin
    Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown', 'do': 'yarn install'}  " live markdown renderer server
    Plug 'rakr/vim-one'                                                                      " colorscheme
    Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}                          " Run live web server to test HTML, CSS, JS
    Plug 'michaelb/sniprun', {'do': 'bash install.sh'}                                       " Instant code runner
    Plug 'rcarriga/nvim-notify'                                                              " Neovim's notification plugin
    Plug 'vim-test/vim-test'                                                                 " Test plugin for Vim
    Plug 'LudoPinelli/comment-box.nvim'
    call plug#end()

    colorscheme one
]])

-- import configurations
require("pkg/colorscheme")
require("pkg/markdown")
require("pkg/nerdtree")
require("pkg/tagbar")
require("pkg/bracey")
require("pkg/test")
require('pkg/dashconfig')
-- require("dashboard")
vim.cmd([[
    source $HOME/.dotfiles/nvim/pkg/coc.vim
]])

-- Treesitter Language List
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"c",
		"cmake",
		"comment",
		"cpp",
		"dockerfile",
		"go",
		"gomod",
		"gdscript",
		"html",
		"http",
		"java",
		"javascript",
		"jsdoc",
		"json",
		"kotlin",
		"latex",
		"lua",
		"make",
		"perl",
		"python",
		"regex",
		"ruby",
		"rust",
		"scheme",
		"scss",
		"svelte",
		"todotxt",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"yaml",
	},
	sync_install = false,
	ignore_install = {},
	highlight = {
		enable = true,
		-- list of language that will be disabled
		disable = {},
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

-- Coc Extensions
vim.g.coc_global_extensions = {
	"coc-clangd",
	"coc-cmake",
	"coc-css",
	"coc-cssmodules",
	"coc-diagnostic",
	"coc-docker",
	"coc-emmet",
	"coc-eslint",
	"coc-explorer",
	"coc-godot",
	"coc-html",
	"coc-html-css-support",
	"coc-htmlhint",
	"coc-java",
	"coc-json",
	"coc-markdown-preview-enhanced",
	"coc-markdownlint",
	"coc-prettier",
	"coc-rls",
	"coc-rust-analyzer",
	"coc-sh",
	"coc-snippets",
	"coc-stylelintplus",
	"coc-stylua",
	"coc-sumneko-lua",
	"coc-sql",
	"coc-tailwindcss",
	"coc-tsserver",
	"coc-ultisnips",
	"coc-vimlsp",
	"coc-webview",
	"coc-xml",
	"coc-yaml",
}

-- Snippet Runner Config
require("sniprun").setup({
	selected_interpreters = {}, -- use those instead of the default for the current filetype
	repl_enable = {}, -- enable REPL-like behavior for the given interpreters
	repl_disable = {}, -- disable REPL-like behavior for the given interpreters
	interpreter_options = { -- interpreter-specific options, see docs / :SnipInfo <name>
		-- use the interpreter name as key
		GFM_original = {
			use_on_filetypes = { "markdown.pandoc" }, -- the 'use_on_filetypes' configuration key is
			-- available for every interpreter
		},
		Python3_original = {
			error_truncate = "auto", -- Truncate runtime errors 'long', 'short' or 'auto'
			-- the hint is available for every interpreter
			-- but may not be always respected
		},
	},
	-- you can combo different display modes as desired
	display = {
		-- "Classic",                             -- display results in the command-line  area
		"VirtualTextOk", -- display ok results as virtual text (multiline is shortened)

		-- "VirtualTextErr",                      -- display error results as virtual text
		"TempFloatingWindow", -- display results in a floating window
		-- "LongTempFloatingWindow",              -- same as above, but only long results. To use with VirtualText__
		-- "Terminal",                            -- display results in a vertical split
		-- "TerminalWithCode",                    -- display results and code history in a vertical split
		-- "NvimNotify",                          -- display with the nvim-notify plugin
		-- "Api"                                  -- return output to a programming interface
	},
	display_options = {
		terminal_width = 45, -- change the terminal display option width
		notification_timeout = 5, -- timeout for nvim_notify output
	},
	-- You can use the same keys to customize whether a sniprun producing
	-- no output should display nothing or '(no output)'
	show_no_output = {
		"Classic",
		"TempFloatingWindow", -- implies LongTempFloatingWindow, which has no effect on its own
	},
	-- customize highlight groups (setting this overrides colorscheme)
	snipruncolors = {
		SniprunVirtualTextOk = { bg = "#66eeff", fg = "#000000", ctermbg = "Cyan", cterfg = "Black" },
		SniprunFloatingWinOk = { fg = "#66eeff", ctermfg = "Cyan" },
		SniprunVirtualTextErr = { bg = "#881515", fg = "#000000", ctermbg = "DarkRed", cterfg = "Black" },
		SniprunFloatingWinErr = { fg = "#881515", ctermfg = "DarkRed" },
	},
	-- miscellaneous compatibility/adjustement settings
	inline_messages = 0, -- inline_message (0/1) is a one-line way to display messages
	-- to workaround sniprun not being able to display anything

	borders = "single", -- display borders around floating windows
	-- possible values are 'none', 'single', 'double', or 'shadow'
	live_mode_toggle = "off", -- live mode toggle, see Usage - Running for more info
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode", "branch" },
		lualine_b = {
			{
				"filename",
				file_status = true, -- Displays file status (readonly status, modified status)
				path = 0, -- 0: Just the filename
				-- 1: Relative path
				-- 2: Absolute path
				-- 3: Absolute path, with tilde as the home directory

				shorting_target = 40, -- Shortens path to leave 40 spaces in the window
				-- for other components. (terrible name, any suggestions?)
				symbols = {
					modified = " * ", -- Text to show when the file is modified.
					readonly = "  ", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
				},
			},
		},
		lualine_c = {
			"CurrentFunction",
			{
				"diff",
				colored = true, -- Displays a colored diff status if set to true
				diff_color = {
					-- Same color values as the general color option can be used here.
					added = "DiffAdd", -- Changes the diff's added color
					modified = "DiffChange", -- Changes the diff's modified color
					removed = "DiffDelete", -- Changes the diff's removed color you
				},
				symbols = { added = "+", modified = "*", removed = "-" }, -- Changes the symbols used by the diff.
				source = nil, -- A function that works as a data source for diff.
				-- It must return a table as such:
				--   { added = add_count, modified = modified_count, removed = removed_count }
				-- or nil on failure. count <= 0 won't be displayed.
			},
		},
		lualine_x = {
			{
				"diagnostics",
				-- Table of diagnostic sources, available sources are:
				--   'nvim_lsp', 'nvim_diagnostic', 'coc', 'ale', 'vim_lsp'.
				-- or a function that returns a table as such:
				--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
				sources = { "nvim_diagnostic", "coc" },
				-- Displays diagnostics for the defined severity types
				sections = { "error", "warn", "info", "hint" },

				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = "DiagnosticError", -- Changes diagnostics' error color.
					warn = "DiagnosticWarn", -- Changes diagnostics' warn color.
					info = "DiagnosticInfo", -- Changes diagnostics' info color.
					hint = "DiagnosticHint", -- Changes diagnostics' hint color.
				},
				symbols = { error = " ⊗ ", warn = "⚠ ", info = "🛈 ", hint = " " },
				colored = true, -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = false, -- Show diagnostics even if there are none.
			},
		},
		lualine_y = { "location" },
		lualine_z = { "encoding", "filetype" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
