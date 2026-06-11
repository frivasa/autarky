local HOME = os.getenv("HOME")
local bindingsmenu = HOME .. "/.local/share/autarky/bin/autarky-menu-keybindings"
local emojimenu = HOME .. "/.local/share/autarky/bin/autarky-menu-emoji"
local powermenu = HOME .. "/.local/share/autarky/bin/autarky-menu-power"
local thememenu = HOME .. "/.local/share/autarky/bin/autarky-menu-themes"
local menu = "fuzzel"
local M = "SUPER + "
local cmd = hl.dsp.exec_cmd

hl.bind(M .. "S", cmd(menu), { description = "app menu (fuzzel)" })
hl.bind(M .. "SLASH", cmd(bindingsmenu), { description = "keymaps (fuzzel)" })
hl.bind(M .. "PERIOD", cmd(emojimenu), { description = "keymaps (fuzzel)" })
hl.bind(M .. "ESCAPE", cmd(powermenu), { description = "power (fuzzel)" })
hl.bind(M .. "SHIFT + T", cmd(thememenu), { description = "themes (fuzzel)" })

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

hl.bind(
	"PRINT",
	cmd("~/.local/share/autarky/bin/autarky-cmd-screenshot selection"),
	{ description = "screenshot (slurp+grim+satty)" }
)
hl.bind(
	"SHIFT + PRINT",
	cmd("~/.local/share/autarky/bin/autarky-cmd-screenshot screen"),
	{ description = "screenshot whole screen (grim+satty)" }
)
hl.bind(
	"ALT + PRINT",
	cmd("~/.local/share/autarky/bin/autarky-cmd-recordregion"),
	{ description = "record region (slurp+wf-record)" }
)
hl.bind(
	"CTRL + PRINT",
	cmd("~/.local/share/autarky/bin/autarky-cmd-recordscreen"),
	{ description = "record screen (wf-record)" }
)
hl.bind(M .. " + PRINT", cmd("hyprpicker -a"), { description = "check colors (hyprpicker)" })
