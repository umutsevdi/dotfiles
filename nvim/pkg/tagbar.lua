vim.g.tagbar_position = "right"
vim.g.tagbar_autoclose = 0
vim.g.tagbar_autofocus = 0
vim.g.tagbar_foldlevel = 2
vim.g.tagbar_autoshowtag = 1
-- Display
vim.g.tagbar_iconchars = {
	"▶",
	"▼",
}
vim.g.tagbar_wrap = 1
vim.g.tagbar_show_data_type = 1
vim.g.tagbar_show_visibility = 1
vim.g.tagbar_visibility_symbols = {
	public = "● ",
	protected = "◯ ",
	private = "◌ ",
}
vim.g.tagbar_show_linenumbers = 1
vim.g.tagbar_show_linenumbers = 1
vim.g.tagbar_case_insensitive = 1
vim.g.tagbar_show_tag_count = 1
vim.g.tagbar_compact = 1
vim.g.tagbar_indent = 1
-- Preview Window
vim.g.tagbar_autopreview = 0
vim.g.tagbar_previewwin_pos = "belowleft"
vim.g.tagbar_scopestrs = {
	class = "\\uf0e8",
	struct = "\\uf0e8",
	const = "\\uf8ff",
	constant = "\\uf8ff",
	enum = "\\uf702",
	field = "\\uf30b",
	func = "\\uf794",
	["function"] = "\\uf794",
	getter = "\\ufab6",
	implementation = "\\uf776",
	interface = "\\uf7fe",
	map = "\\ufb44",
	member = "\\uf02b",
	method = "\\uf6a6",
	setter = "\\uf7a9",
	variable = "\\uf71b",
}
