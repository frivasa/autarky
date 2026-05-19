-- Laptop multimedia keys for volume and LCD brightness
local osd = "swayosd-client --monitor "
local monitor = "$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name') "

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(osd .. monitor .. " --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(osd .. monitor .. " --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(osd .. monitor .. " --output-volume mute-toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(osd .. monitor .. " --brightness raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(osd .. monitor .. " --brightness lower"),
	{ locked = true, repeating = true }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osd .. monitor .. " --playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osd .. monitor .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osd .. monitor .. " --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osd .. monitor .. " --playerctl previous"), { locked = true })
