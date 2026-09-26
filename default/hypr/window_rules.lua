-- base "all windows" rule
hl.window_rule({
	match = { class = ".*" },
	-- focused, unfocused, fullscreen
	opacity = "1.0 override 1.0 override 1.0 override",
})

-- float auxiliary apps (bluetooth, wifi, sound)
hl.window_rule({
	match = { class = "^(blueberry.py|Impala|Wiremix|Autarky|About)$" },
	float = true,
	center = true,
	size = { 800, 600 },
	opacity = "0.9 override 0.9 override 1.0 override",
})

-- Float and center file pickers
hl.window_rule({
	match = { class = "xdg-desktop-portal-gtk", title = "^(Open.*Files?|Save.*Files?|All Files|Save)" },
	float = true,
	center = true,
})

-- Float and center steam
hl.window_rule({
	match = { class = "steam", title = "Steam" },
	float = true,
	center = true,
	opacity = "1.0 1.0 1.0",
})

hl.window_rule({
	match = { class = "^(?i)(zen|zen-browser)$" },
	opacity = "1.0 1.0 1.0",
})

hl.window_rule({
	match = { title = "^.*MultiViewer.*$" },
	opacity = "1.0 1.0 1.0",
})

hl.window_rule({
	match = { title = "^.*YouTube.*$" },
	opacity = "1.0 1.0 1.0",
})

hl.window_rule({
	match = {
		class = "^(rawtherapee|zoom|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv)$",
	},
	opacity = "1.0 1.0 1.0",
})

-- treat non-wayland as popups
hl.window_rule({
	match = { xwayland = true },
	float = true,
	center = true,
	fullscreen = false,
	pin = false,
})
