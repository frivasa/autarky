-- Cursor size
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_SCALE_FACTOR", 1.3333)
hl.env("QT_WAYLAND_FORCE_DPI", 96)
hl.env("MOZ_ENABLE_WAYLAND", 1)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")

-- Use XCompose file
hl.env("XCOMPOSEFILE", "~/.XCompose")

-- hyprland's former "autostart" with "exec-once"s
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- hypridle")
	hl.exec_cmd("uwsm app -- mako")
	hl.exec_cmd("uwsm app -- waybar")
	hl.exec_cmd("uwsm app -- fcitx5")
	hl.exec_cmd("uwsm app -- swaybg -i ~/.config/autarky/current/background -m fill")
	hl.exec_cmd("uwsm app -- swayosd-server")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("wl-clip-persist --clipboard regular --all-mime-type-regex '^(?!x-kde-passwordManagerHint).+'")
	hl.exec_cmd("hyprlock")
end)
