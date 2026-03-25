{ ... }:
{
  home.file.".config/waybar/config.jsonc" = {
    text = ''
      {
        "reload_style_on_change": true,
        "layer": "top",
        "position": "top",
        "spacing": 0,
        "height": 16,
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["clock"],
        "modules-right": [
          "custom/nightlight",
          "custom/media",
          "custom/screenshot",
          "group/tray-expander",
          "bluetooth",
          "network",
          "pulseaudio",
          "cpu",
          "memory"
        ],
        "clock": {
          "format": "{:%A %H:%M}",
          "format-alt": "{:%d %B W%V %Y}",
          "tooltip": false
        },
        "cpu": {
          "interval": 5,
          "format": "󰍛 {usage}%",
          "tooltip": true,
          "on-click": "kitty -e btop"
        },
        "memory": {
          "interval": 5,
          "format": "󰾆 {percentage}%",
          "tooltip-format": "{used:0.1f}G / {total:0.1f}G"
        },
        "custom/media": {
          "format": "{}",
          "return-type": "json",
          "exec": "playerctl -a metadata --format '{\"text\": \"{{emoji(status)}} {{title}}\", \"tooltip\": \"{{playerName}}: {{title}} — {{artist}}\", \"class\": \"{{status}}\"}' -F 2>/dev/null",
          "on-click": "playerctl play-pause",
          "max-length": 30
        },
        "custom/nightlight": {
          "format": "{}",
          "exec": "if pgrep -x hyprsunset > /dev/null; then echo '󰛨'; else echo '󰛩'; fi",
          "interval": 2,
          "on-click": "bash ~/.local/bin/wlsunset-toggle.sh",
          "signal": 8,
          "tooltip-format": "Night light toggle"
        },
        "pulseaudio": {
          "format": "{icon} {volume}%",
          "format-muted": "󰝟 muted",
          "scroll-step": 5,
          "on-click": "kitty -e wiremix",
          "on-click-right": "pamixer -t",
          "tooltip-format": "Volume: {volume}%",
          "format-icons": {
            "headphone": "",
            "headset": "",
            "default": ["", "", ""]
          }
        },
        "network": {
          "format-icons": ["󰤯", "󰤟", "󰤢", "󰤥", "󰤨"],
          "format": "{icon}",
          "format-wifi": "{icon}",
          "format-ethernet": "󰀂",
          "format-disconnected": "󰤮",
          "tooltip-format-wifi": "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
          "tooltip-format-ethernet": "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}",
          "tooltip-format-disconnected": "Disconnected",
          "interval": 3,
          "on-click": "kitty -e nmtui"
        },
        "bluetooth": {
          "format": "",
          "format-off": "󰂲",
          "format-disabled": "󰂲",
          "format-connected": "󰂱",
          "format-no-controller": "",
          "tooltip-format": "Devices connected: {num_connections}",
          "on-click": "blueman-manager"
        },
        "custom/screenshot": {
          "format": "󰄀",
          "tooltip-format": "Screenshot\nLeft: region\nRight: fullscreen",
          "on-click": "bash ~/.local/bin/screenshot-capture-wayland.sh region",
          "on-click-right": "bash ~/.local/bin/screenshot-capture-wayland.sh"
        },
        "group/tray-expander": {
          "orientation": "inherit",
          "drawer": {
            "transition-duration": 600,
            "children-class": "tray-group-item"
          },
          "modules": ["custom/expand-icon", "tray"]
        },
        "custom/expand-icon": {
          "format": "",
          "tooltip": false
        },
        "tray": {
          "icon-size": 12,
          "spacing": 17
        }
      }
    '';
  };

  home.file.".config/waybar/style.css" = {
    text = ''
      * {
        font-family: 'JetBrainsMono Nerd Font';
        font-size: 13px;
        font-weight: 600;
        min-height: 0;
        border: none;
        border-radius: 0;
      }
      window#waybar {
        background-color: #242424;
        color: #ebdbb2;
        border-bottom: 2px solid #7daea3;
      }
      .modules-left  { margin-left:  8px; }
      .modules-right { margin-right: 8px; }
      #workspaces button {
        all: initial;
        font-family: 'JetBrainsMono Nerd Font';
        font-size: 13px;
        font-weight: 600;
        padding: 0 4px;
        margin: 0 1.5px;
        min-width: 9px;
        color: #bdae93;
        opacity: 0.6;
      }
      #workspaces button.active {
        color: #242424;
        background-color: #b8bb26;
        opacity: 1.0;
      }
      #workspaces button.nonempty {
        color: #fabd2f;
        opacity: 1.0;
      }
      #workspaces button.urgent {
        color: #fbf1c7;
        background-color: #fb4934;
        opacity: 1.0;
      }
      #clock {
        color: #ebdbb2;
        font-weight: 700;
        margin-left: 8.75px;
      }
      #cpu,
      #memory,
      #pulseaudio,
      #network,
      #bluetooth,
      #custom-expand-icon {
        min-width: 12px;
        margin: 0 7.5px;
        color: #d5c4a1;
      }
      #tray              { margin-right: 16px; }
      #bluetooth         { margin-right: 17px; }
      #network           { margin-right: 13px; }
      #custom-expand-icon { margin-right: 18px; }
      .tray-group-item   { margin: 0 4px; }
      #pulseaudio.muted        { color: #fb4934; }
      #network.disconnected    { color: #fb4934; }
      #bluetooth.off           { color: #504945; }
      #custom-screenshot {
        margin: 0 7.5px;
        color: #ebdbb2;
      }
      #custom-screenshot:hover { color: #7daea3; }
      #custom-media             { color: #ebdbb2; }
      #custom-media.Paused      { color: #665c54; }
      #custom-nightlight {
        color: #ebdbb2;
        margin: 0 7.5px;
      }
      #custom-nightlight:hover { color: #fe8019; }
      tooltip {
        background-color: #3c3836;
        border: 1px solid #7daea3;
        padding: 2px;
      }
      tooltip label { color: #fbf1c7; }
    '';
  };
}
