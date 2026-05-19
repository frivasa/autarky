local mod = "SUPER"

-- Move focus with mod + hjkl
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Swap windows with mod + arrows
hl.bind(mod .. " + left", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.window.swap({ direction = "down" }))

hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + TAB", hl.dsp.window.bring_to_top())

hl.bind(mod .. " + W", hl.dsp.window.close())
hl.bind(mod .. " + R", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mod .. " + Y", function()
	hl.dispatch(hl.dsp.window.pin({ action = "toggle" }))
end)
hl.bind(mod .. " + F", hl.dsp.window.float({ action = "toggle" }))

-- Switch workspaces with mod + [0-9]
-- Move active window to a workspace with mod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mod + scroll
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mod + LMB/RMB and dragging
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mod .. " + MINUS", hl.dsp.window.resize({ x = -100, y = 0, relative = true }, { repeating = true }))
hl.bind(mod .. " + EQUAL", hl.dsp.window.resize({ x = 100, y = 0, relative = true }, { repeating = true }))
hl.bind(mod .. " + SHIFT + MINUS", hl.dsp.window.resize({ x = 0, y = 100, relative = true }, { repeating = true }))
hl.bind(mod .. " + SHIFT + EQUAL", hl.dsp.window.resize({ x = 0, y = -100, relative = true }, { repeating = true }))

-- toggle fullscreen window (not the app)
hl.bind(mod .. " + CTRL + SHIFT + K", hl.dsp.window.fullscreen({ internal = 2, client = 0, action = "toggle" }))
