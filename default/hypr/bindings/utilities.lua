local HOME = os.getenv("HOME")
local bindingsmenu = HOME .. "/.local/share/autarky/bin/autarky-menu-keybindings"
local powermenu = HOME .. "/.local/share/autarky/bin/autarky-menu-power"
local menu = "walker"
local M = "SUPER + "
local cmd = hl.dsp.exec_cmd

hl.bind(M .. "S", cmd(menu), { description = "app menu (walker)" })
hl.bind(M .. "SLASH", cmd(bindingsmenu), { description = "keymaps (walker)" })
hl.bind(M .. "ESCAPE", cmd(powermenu), { description = "power (walker)" })

hl.bind(M .. "SPACE", cmd("pkill -SIGUSR1 waybar"), { description = "toggle waybar" })
hl.bind(
	M .. "SHIFT + CTRL + SPACE",
	cmd("~/.local/share/autarky/bin/autarky-theme-bg-next"),
	{ description = "switch background" }
)
hl.bind(M .. "CTRL + SPACE", cmd("~/.local/share/autarky/bin/autarky-theme-next"), { description = "next theme" })
hl.bind(M .. "COMMA", cmd("makoctl dismiss"), { description = "clear notification" })
hl.bind(M .. "SHIFT + COMMA", cmd("makoctl dismiss --all"), { description = "clear all notifications" })
local dnd = "makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb'"
local dnd_notification = 'notify-send "Silenced notifications" || notify-send "Enabled notifications"'
hl.bind(M .. "CTRL + COMMA", cmd(dnd .. " && " .. dnd_notification), { description = "silence notifications" })
hl.bind(M .. "CTRL + I", cmd("~/.local/share/autarky/bin/autarky-toggle-idle"), { description = "toggle idle" })

-- these are hit or miss, check the scripts
hl.bind("PRINT", cmd("./~/.local/share/autarky/bin/autarky-cmd-screenshot"), { description = "screenshot (satty)" })
hl.bind(
	"SHIFT + PRINT",
	cmd("./~/.local/share/autarky/bin/autarky-cmd-screenshot window"),
	{ description = "screenshot window" }
)
hl.bind(
	"CTRL + PRINT",
	cmd("~/.local/share/autarky/bin/autarky-cmd-screenshot output"),
	{ description = "screenshot output" }
)
hl.bind("ALT + PRINT", cmd("~/.local/share/autarky/bin/autarky-cmd-screenrecord"), { description = "record window" })
hl.bind(
	"CTRL + ALT + PRINT",
	cmd("~/.local/share/autarky/bin/autarky-cmd-screenrecord output"),
	{ description = "record output" }
)

hl.bind(M .. " + PRINT", cmd("hyprpicker -a"), { description = "check colors (hyprpicker)" })
-- something wrong with screensaver config T>T
hl.bind(
	M .. " + ALT + SPACE",
	cmd("~/.local/share/autarky/bin/autarky-launch-screensaver"),
	{ description = "screensaver" }
)
