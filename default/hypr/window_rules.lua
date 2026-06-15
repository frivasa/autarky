-- windowrule = suppress_event maximize, match:class .*
hl.window_rule({
	name = "prevent maximize on all windows?",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- float auxiliary apps (bluetooth, wifi, sound)
hl.window_rule({
	match = { class = "^(blueberry.py|Impala|Wiremix|Autarky|About)$" },
	float = true,
	center = true,
	size = { 800, 600 },
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

-- Opacity rules
hl.window_rule({
	match = { class = ".*" },
	-- opacity = "0.98 0.85 1.0",
	opacity = "0.98 0.85 1.0",
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
		class = "^(zoom|mpv|org.kde.kdenlive|com.obsproject.Studio|com.github.PintaProject.Pinta|imv)$",
	},
	opacity = "1.0 1.0 1.0",
})

hl.window_rule({
	match = { xwayland = true },
	float = true,
	center = true,
	fullscreen = false,
	pin = false,
})
