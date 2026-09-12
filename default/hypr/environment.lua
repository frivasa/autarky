-- only hyprland env vars here, everything else to .config/uwsm/env
hl.env("HYPRCURSOR_SIZE", 24)
-- XCompose file is being handled by fcitx
-- hyprland's former "autostart" with "exec-once"s
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- hypridle")
	hl.exec_cmd("uwsm app -- mako")
	hl.exec_cmd("uwsm app -- waybar")
	hl.exec_cmd("uwsm app -- swaybg -i ~/.config/autarky/current/background -m fill")
	hl.exec_cmd("uwsm app -- swayosd-server")
	hl.exec_cmd("uwsm app -- foot --server")
	hl.exec_cmd("uwsm app -- fcitx5 -d")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("wl-clip-persist --clipboard regular --all-mime-type-regex '^(?!x-kde-passwordManagerHint).+'")
	hl.exec_cmd("hyprlock")
end)
