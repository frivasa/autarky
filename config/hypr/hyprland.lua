-- HYPR* apps (hyprlock, hypridle, etc) ARE NOT LUA (yet?)

local HOME = os.getenv("HOME")
local autarky = "/.local/share/autarky/default/hypr/"
local config_files = {
	"bindings/utilities.lua",
	"bindings/tiling.lua",
	"bindings/media.lua",
	"window_rules.lua",
	"environment.lua",
	"input.lua",
}
for _, file in ipairs(config_files) do
	dofile(HOME .. autarky .. file)
end

package.path = package.path .. ";" .. HOME .. "/.config/autarky/current/theme/hyprland_colors.lua"
local colors = require("hyprland_colors")
require("monitors.lua")

local terminal = "uwsm app -- kitty "
local fileManager = "uwsm app -- nautilus "
local browser = "uwsm app -- zen-browser --new-window "
local webapp = browser .. "--app "
local seshpick = HOME .. "/.local/share/autarky/bin/autarky-session-pick"

local mainMod = "SUPER"
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal .. seshpick))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal .. seshpick))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(terminal .. " -e nvim"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(terminal .. " -e btop"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(terminal .. " -e lazydocker"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("uwsm app -- obsidian -disable-gpu"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("uwsm app -- keepassxc"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(webapp .. "https://chatgpt.com/"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(webapp .. "https://apod.nasa.gov/apod/"))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exec_cmd(webapp .. "https://youtube.com/"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(webapp .. "https://web.whatsapp.com/"))

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
