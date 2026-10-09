local HOME = os.getenv("HOME")
local bindingsmenu = HOME .. "/.local/share/autarky/bin/autarky-menu-keybindings"
local emojimenu = HOME .. "/.local/share/autarky/bin/autarky-menu-emoji"
local powermenu = HOME .. "/.local/share/autarky/bin/autarky-menu-power"
local thememenu = HOME .. "/.local/share/autarky/bin/autarky-menu-themes"
local M = "SUPER + "
local cmd = hl.dsp.exec_cmd

hl.bind(M .. "S", cmd("noctalia msg panel-toggle launcher"), {
	description = "app menu (Noctalia)",
})
hl.bind(M .. "SLASH", cmd(bindingsmenu), { description = "keymaps (noctalia)" })
hl.bind(M .. "PERIOD", cmd(emojimenu), { description = "emojis/xcompose (noctalia)" })
hl.bind(M .. "SHIFT + ESCAPE", cmd(powermenu), { description = "power (noctalia)" })
hl.bind(M .. "SHIFT + T", cmd(thememenu), { description = "themes (noctalia)" })

hl.bind(M .. "SPACE", cmd("noctalia msg bar-toggle"), {
	description = "toggle Noctalia bar",
})
hl.bind(
	M .. "SHIFT + CTRL + SPACE",
	cmd("~/.local/share/autarky/bin/autarky-theme-bg-next"),
	{ description = "switch background" }
)
hl.bind(M .. "ESCAPE", cmd("noctalia msg notification-clear-active"), {
	description = "clear all notifications",
})
hl.bind(M .. "CTRL + COMMA", cmd("noctalia msg notification-dnd-toggle"), {
	description = "toggle do not disturb",
})
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
