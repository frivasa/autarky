hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_rules = "",
		kb_options = "compose:ralt",
		repeat_rate = 40,
		repeat_delay = 600,
		sensitivity = 0.3,
		accel_profile = "flat",
		follow_mouse = 1,
		touchpad = {
			scroll_factor = 0.4,
			natural_scroll = false,
			disable_while_typing = true,
		},
	},
})

hl.device({
	name = "logitech-wireless-mouse-1",
	sensitivity = -0.8,
})
