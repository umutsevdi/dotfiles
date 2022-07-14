local home = os.getenv("HOME")
local db = require("dashboard")
db.custom_header = {
	" ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	" ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	" ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	" ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	" ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	" ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}
db.custom_center = {
	{
		icon = " ",
		desc = "New File            ",
		action = "DashboardNewFile",
	},
	{
		icon = " ",
		desc = "Find  File          ",
		action = "Telescope find_files",
	},
	{
		icon = "  ",
		desc = "Recent Files        ",
		action = "lua require('user.plugins.config.telescope.sources').frecency()",
	},
	{
		icon = "  ",
		desc = "Git Status          ",
		action = "Telescope git_status",
	},
	{
		icon = " ",
		desc = "Update              ",
		action = "PlugUpdate",
	},
	{
		icon = " ",
		desc = "Quit                ",
		action = "qa",
	},
}
db.hide_statusline = false
db.hide_tabline = false
db.custom_footer = {
	{ desc = " umutsevdi" },
}
