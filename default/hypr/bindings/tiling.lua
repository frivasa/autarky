local M = "SUPER + "

-- Move focus with M + hjkl
hl.bind(M .. "h", hl.dsp.focus({ direction = "left" }), { description = "focus left" })
hl.bind(M .. "l", hl.dsp.focus({ direction = "right" }), { description = "focus right" })
hl.bind(M .. "k", hl.dsp.focus({ direction = "up" }), { description = "focus up" })
hl.bind(M .. "j", hl.dsp.focus({ direction = "down" }), { description = "focus down" })

-- Swap windows with M + arrows
hl.bind(M .. "left", hl.dsp.window.swap({ direction = "left" }), { description = "swap left" })
hl.bind(M .. "right", hl.dsp.window.swap({ direction = "right" }), { description = "swap right" })
hl.bind(M .. "up", hl.dsp.window.swap({ direction = "up" }), { description = "swap up" })
hl.bind(M .. "down", hl.dsp.window.swap({ direction = "down" }), { description = "swap down" })

hl.bind("ALT + TAB", hl.dsp.window.cycle_next(), { description = "cycle window" })
hl.bind("ALT + TAB", hl.dsp.window.bring_to_top(), { description = "cycle window" })

hl.bind(M .. "W", hl.dsp.window.close(), { description = "close window" })
hl.bind(M .. "R", hl.dsp.layout("togglesplit"), { description = "rotate split (dwindle)" }) -- dwindle only
hl.bind(M .. "Y", function()
	hl.dispatch(hl.dsp.window.pin({ action = "toggle" }))
end, { description = "pin toggle" })
hl.bind(M .. "F", hl.dsp.window.float({ action = "toggle" }), { description = "float toggle" })

-- Switch workspaces with M + [0-9]
-- Move active window to a workspace with M + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(M .. " + " .. key, hl.dsp.focus({ workspace = i }), { description = "focus workspace " .. i })
	hl.bind(
		M .. " + SHIFT + " .. key,
		hl.dsp.window.move({ workspace = i }),
		{ description = "move to workspace " .. i }
	)
end

-- Scroll through existing workspaces with M + scroll
hl.bind(M .. "mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "scroll workspace down" })
hl.bind(M .. "mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "scroll workspace up" })

-- Move/resize windows with M + LMB/RMB and dragging
hl.bind(M .. "mouse:272", hl.dsp.window.drag(), { mouse = true, description = "mouse window drag" })
hl.bind(M .. "mouse:273", hl.dsp.window.resize(), { mouse = true, description = "mouse window resize" })

hl.bind(
	M .. "MINUS",
	hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
	{ repeating = true, description = "resize x left" }
)
hl.bind(
	M .. "EQUAL",
	hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
	{ repeating = true, description = "resize x right" }
)
hl.bind(
	M .. "SHIFT + MINUS",
	hl.dsp.window.resize({ x = 0, y = 100, relative = true }),
	{ repeating = true, description = "resize y up" }
)
hl.bind(
	M .. "SHIFT + EQUAL",
	hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
	{ repeating = true, description = "resize y down" }
)

-- toggle fullscreen window (not the app)
hl.bind(
	M .. "CTRL + SHIFT + K",
	hl.dsp.window.fullscreen({ internal = 2, client = 0, action = "toggle" }),
	{ description = "toggle fullscreen" }
)
