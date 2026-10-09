-- Laptop multimedia keys for volume and LCD brightness
local cmd = hl.dsp.exec_cmd

hl.bind("XF86AudioRaiseVolume", cmd("noctalia msg volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", cmd("noctalia msg volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", cmd("noctalia msg volume-mute"), { locked = true })

-- LCD brightness
hl.bind("XF86MonBrightnessUp", cmd("noctalia msg brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", cmd("noctalia msg brightness-down"), { locked = true, repeating = true })

-- Media controls (requires playerctl)
hl.bind("XF86AudioNext", cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", cmd("playerctl previous"), { locked = true })
