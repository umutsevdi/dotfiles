local home = os.getenv("HOME")
local db = require("dashboard")

local ascii = {
"            ⡀              ⢀                     ",
"          ⡠⢊⠔⠠             ⠠⡑⢄                   ",
"        ⡠⢊⠔⡡⠊⠄⠅⡀           ⢐⢌⠢⡑⢄                 ",
"      ⡠⡊⢔⠡⡊⢔⠡⢁⠂⡂⠄          ⢐⢔⢑⢌⠢⡑⢄               ",
"    ⢀⠪⡐⢌⡂⡢⢊⠔⡨⢐⠨⠠⢁⢂         ⢐⢔⢑⢔⢑⢌⠢⡑⠄             ",
"    ⠠⡑⢌⠢⡊⡢⠡⡑⡐⡐⠨⢐⢁⢂⢂        ⢐⢌⠢⡢⡑⢔⢑⢌⢂             ",
"    ⠨⡨⠢⡑⡌⠜⡌⡂⡢⠨⠨⢐⢐⠠⢂⠅       ⢐⢅⠕⡌⡊⢆⠕⢌⢂             ",
"    ⠨⡂⡣⡑⢌⢪⠨⡒⡌⠌⡨⢐⢐⠨⢐⠨⠨⠠     ⢐⢅⠕⡌⡪⡂⢇⠕⠅             ",
"    ⠨⢢⢑⠜⢌⢢⠱⡨⡂⢁⠢⡁⠢⡈⠢⠨⠨⡈⡂    ⠨⡢⢣⠱⡨⡊⢆⠣⡃             ",
"    ⠨⡊⢆⠣⡣⡑⢕⢌⠂ ⠐⠌⡂⠪⠨⠨⠨⡂⡂⡢⡀  ⢘⢌⠆⡇⡪⡸⡨⢪⠂             ",
"    ⠨⡊⢎⠪⡢⢱⢑⠜⡄  ⠈⠌⢌⠪⡈⡪⢐⢐⢐⠌⢄ ⢨⠢⡣⡱⡑⡌⢎⢆⡃             ",
"    ⠨⡪⡊⡎⡪⡊⡆⢇⠅   ⠈⠐⢌⠢⡈⡂⡪⠠⡑⠄⢅⠰⡑⡕⢜⢌⢎⢪⢢⢂             ",
"    ⢨⢢⢣⠪⡪⡸⡨⡪⡂     ⠑⢌⢂⢊⠢⡑⠌⢌⠢⡑⢕⢱⢑⢕⢜⢔⢕⠅             ",
"    ⢐⢕⢜⢜⢌⢆⢇⢎⠆      ⠐⡐⡑⢌⠢⡑⡑⠌⢌⢪⠸⡸⡰⡱⡸⡰⡡             ",
"    ⢨⢪⢪⢢⢣⢣⢣⢱⡁        ⠪⡐⢅⠢⠪⠨⡊⢆⢣⠱⡸⡸⡨⡪⡂             ",
"    ⠐⢕⢕⢕⢕⢕⢕⢕⡂         ⠨⠢⡡⠣⡑⡸⡨⢢⠣⡑⡕⡕⡕⠅             ",
"      ⠑⢕⢕⢕⢕⢕⠆           ⠑⢌⢌⠢⢪⠸⡰⡑⡕⢜⠌⠄             ",
"        ⠑⢕⢕⡕⡅             ⠢⠣⡑⢕⢱⢘⠌                ",
"          ⠑⠵⡅              ⠱⢸⢘⠌                  ",
"           ⠈⠂⠄              ⠁⠁                   ",
}

db.custom_header = ascii
db.custom_center = {
	{
		icon = "  ",
		desc = "New File                                ",
		action = "DashboardNewFile",
	},
	{
		icon = "ﰍ  ",
		desc = "Find  File                              ",
		action = "Telescope find_files",
	},
	{
		icon = "  ",
		desc = "Git Branches                             ",
		action = "Telescope git_branches",
	},
	{
		icon = "  ",
		desc = "Git Status                              ",
		action = "Telescope git_status",
	},
}
db.hide_statusline = false
db.hide_tabline = false
db.custom_footer = {
	{ desc = " umutsevdi" },
}
