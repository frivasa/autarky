-- Laptop multimedia keys for volume and LCD brightness
local osd = "swayosd-client --monitor "
local monitor = "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name') "
local cmd = hl.dsp.exec_cmd

hl.bind("XF86AudioRaiseVolume", cmd(osd .. monitor .. " --output-volume raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", cmd(osd .. monitor .. " --output-volume lower"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", cmd(osd .. monitor .. " --output-volume mute-toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", cmd(osd .. monitor .. " --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", cmd(osd .. monitor .. " --brightness lower"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", cmd(osd .. monitor .. " --playerctl next"), { locked = true })
hl.bind("XF86AudioPause", cmd(osd .. monitor .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", cmd(osd .. monitor .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", cmd(osd .. monitor .. " --playerctl previous"), { locked = true })
