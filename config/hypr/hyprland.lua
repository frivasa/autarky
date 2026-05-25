-- HYPR* apps (hyprlock, hypridle, etc) ARE NOT LUA (yet?)

local HOME = os.getenv("HOME")
local autarky = "/.local/share/autarky/default/hypr/"
local config_files = {
	"bindings/media.lua",
	"bindings/tiling.lua",
	"bindings/utilities.lua",
	"environment.lua",
	"input.lua",
	"window_rules.lua",
}
for _, file in ipairs(config_files) do
	dofile(HOME .. autarky .. file)
end

-- package.path for packages that need to return something
package.path = package.path .. ";" .. HOME .. "/.config/autarky/current/theme/hyprland_colors.lua"
local colors = require("hyprland_colors")
-- "import" adjacent files (files living at or below hyprland.lua)
require("monitors")

local terminal = "uwsm app -- kitty "
local fileManager = "uwsm app -- nautilus "
local browser = "uwsm app -- zen-browser --new-window "
local webapp = browser .. "--app "
local seshpick = terminal .. HOME .. "/.local/share/autarky/bin/autarky-session-pick"

local M = "SUPER + "
local cmd = hl.dsp.exec_cmd
hl.bind(M .. "RETURN", cmd(seshpick), { description = "term (kitty+tmux)" })
hl.bind(M .. "T", cmd(seshpick), { description = "term (kitty+tmux" })
hl.bind(M .. "E", cmd(fileManager), { description = "file manager (nautilus)" })
hl.bind(M .. "B", cmd(browser), { description = "browser (zen)" })
hl.bind(M .. "N", cmd(terminal .. " -e nvim"), { description = "god notepad (nvim)" })
hl.bind(M .. "P", cmd(terminal .. " -e btop"), { description = "system monitor (btop)" })
hl.bind(M .. "D", cmd(terminal .. " -e lazydocker"), { description = "lazy docker" })
hl.bind(M .. "O", cmd("uwsm app -- obsidian -disable-gpu"), { description = "obsidian" })
hl.bind(M .. "SHIFT + P", cmd("uwsm app -- keepassxc"), { description = "keepassxc" })
hl.bind(M .. "SHIFT + C", cmd(webapp .. "https://chatgpt.com/"), { description = "chatGPT" })
hl.bind(M .. "SHIFT + A", cmd(webapp .. "https://apod.nasa.gov/apod/"), { description = "NASA's APOD" })
hl.bind(M .. "SHIFT + W", cmd(webapp .. "https://web.whatsapp.com/"), { description = "chat (whatsapp)" })

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 5,
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
		col = { active_border = colors.active_border, inactive_border = colors.inactive_border },
	},
	decoration = {
		rounding = 8,
		shadow = { enabled = true, range = 2, render_power = 3, color = "rgba(1a1a1aee)" },
		blur = { enabled = true, size = 3, passes = 1, vibrancy = 0.1696 },
	},
	animations = { enabled = false },
	dwindle = { preserve_split = true, force_split = 2 },
	cursor = { inactive_timeout = 2.0 },
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		focus_on_activate = false,
		disable_splash_rendering = true,
	},
	xwayland = { force_zero_scaling = true },
	ecosystem = { no_update_news = true },
})

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})
