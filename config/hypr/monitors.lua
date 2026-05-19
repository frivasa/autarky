-- # Laptop panel (master)
hl.env("GDK_SCALE", 2)

hl.monitor({
	output = "eDP-1",
	mode = "3200x1800@60",
	position = "0x0",
	scale = 2,
})

hl.monitor({
	output = "DP-1",
	mode = "preferred",
	position = "1600x0",
	scale = 1,
})
