local HOME = os.getenv("HOME")
local bindingsmenu = HOME .. "/.local/share/autarky/bin/autarky-menu-keybindings"
local powermenu = HOME .. "/.local/share/autarky/bin/autarky-menu-power"
local menu = "walker"
local mod = "SUPER"

hl.bind(mod .. " + S", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + SLASH", hl.dsp.exec_cmd(bindingsmenu))
hl.bind(mod .. " + ESCAPE", hl.dsp.exec_cmd(powermenu))

hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))
hl.bind(mod .. " + SHIFT + CTRL + SPACE", hl.dsp.exec_cmd("~/.local/share/autarky/bin/autarky-theme-bg-next"))
hl.bind(mod .. " + CTRL + SPACE", hl.dsp.exec_cmd("~/.local/share/autarky/bin/autarky-theme-next"))
hl.bind(mod .. " + COMMA", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind(mod .. " + SHIFT + COMMA", hl.dsp.exec_cmd("makoctl dismiss --all"))
local dnd = "makoctl mode -t do-not-disturb && makoctl mode | grep -q 'do-not-disturb'"
local dnd_notification = 'notify-send "Silenced notifications" || notify-send "Enabled notifications"'
hl.bind(mod .. " + CTRL + COMMA", hl.dsp.exec_cmd(dnd .. " && " .. dnd_notification))
hl.bind(mod .. " + CTRL + I", hl.dsp.exec_cmd("~/.local/share/autarky/bin/autarky-toggle-idle"))

-- these are hit or miss, check the scripts
hl.bind("PRINT", hl.dsp.exec_cmd("./~/.local/share/autarky/bin/autarky-cmd-screenshot"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("./~/.local/share/autarky/bin/autarky-cmd-screenshot window"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("~/.local/share/autarky/bin/autarky-cmd-screenshot output"))
hl.bind("ALT + PRINT", hl.dsp.exec_cmd("~/.local/share/autarky/bin/autarky-cmd-screenrecord"))
hl.bind("CTRL + ALT + PRINT", hl.dsp.exec_cmd("~/.local/share/autarky/bin/autarky-cmd-screenrecord output"))

hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("hyprpicker -a"))
-- something wrong with screensaver config T>T
hl.bind(mod .. " + ALT + SPACE", hl.dsp.exec_cmd("~/.local/share/autarky/bin/autarky-launch-screensaver"))
