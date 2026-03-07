{ config, pkgs, ... }:

{
  home.username = "az";
  home.homeDirectory = "/home/az";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      eval "$(starship init bash)"
      eval "$(zoxide init bash)"
      eval "$(atuin init bash)"
      source <(fzf --bash)
    '';
    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      cat = "bat";
      cd = "z";
      vim = "nvim";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[❯](bold #c2185b)";
        error_symbol = "[❯](bold red)";
      };
      nix_shell.symbol = " ";
      git_branch.symbol = " ";
      directory.truncation_length = 3;
    };
  };

programs.git = {
  enable = true;
  settings = {
    user.name = "shaonahmedronok1";
    user.email = "shaonbtw@gmail.com";
    init.defaultBranch = "main";
    pull.rebase = false;
  };
};


programs.alacritty = {
  enable = true;
  settings = {
    window.padding = { x = 10; y = 10; };
    font = {
      normal.family = "JetBrainsMono Nerd Font";
      size = 17;
    };
    
    colors = {
  primary = {
    background = "#282828";
    foreground = "#ebdbb2";
  };
  cursor = {
    text = "#282828";
    cursor = "#c2185b";
  };
};
   cursor.style = "Block";
    window.opacity = 1.0;
  };
};


services.mako = {
  enable = true;
  settings = {
    background-color = "#fef9f0";
    text-color = "#0a0a0a";
    border-color = "#c2185b";
    border-size = 2;
    border-radius = 6;
  };
};

programs.fuzzel = {
  enable = true;
  settings = {
    main = {
      font = "JetBrainsMono Nerd Font:size=16";
      lines = 12;
      width = 45;
    };
    colors = {
      background = "fef9f0ff";
      selection = "c2185bff";
      text = "0a0a0aff";
      selection-text = "fef9f0ff";
    };
    border = {
      width = 2;
      radius = 6;
    };
  };
};

programs.swaylock = {
  enable = true;
  settings = {
    color = "fef9f0";
    ring-color = "c2185b";
    inside-color = "fef9f0";
    text-color = "0a0a0a";
    indicator-radius = 80;
  };
};




home.file.".config/river/init" = {
  executable = true;
  text = ''
    #!/bin/sh

    # ===== ENVIRONMENT =====
    export XDG_CURRENT_DESKTOP=river
    export XDG_SESSION_TYPE=wayland
    export QT_QPA_PLATFORM=wayland
    export MOZ_ENABLE_WAYLAND=1

    # ===== DBUS =====
    dbus-update-activation-environment --systemd \
      WAYLAND_DISPLAY \
      XDG_CURRENT_DESKTOP \
      XDG_SESSION_TYPE \
      QT_QPA_PLATFORM
    systemctl --user import-environment \
      WAYLAND_DISPLAY \
      XDG_CURRENT_DESKTOP \
      XDG_SESSION_TYPE

    # ===== AUTOSTART =====
    riverctl spawn "mako"
    riverctl spawn "$HOME/.config/river/wallpaper-loader.sh"
    riverctl spawn "udiskie -t"
    riverctl spawn "waybar"
    riverctl spawn "flameshot"
    riverctl spawn "swayidle -w timeout 300 'swaylock -f' timeout 600 'systemctl suspend' before-sleep 'swaylock -f'"
    riverctl spawn "wl-clip-persist --clipboard regular"

    # ===== KEYBOARD =====
    riverctl keyboard-layout us
    riverctl set-repeat 50 300

    # ===== KEYBINDS =====
    riverctl map normal Super Return spawn alacritty
    riverctl map normal Super Space spawn "fuzzel --show drun"
    riverctl map normal Super B spawn chromium
    riverctl map normal Super C close
    riverctl map normal Super+Shift E exit
    riverctl map normal Super F toggle-fullscreen
    riverctl map normal Super+Shift Space toggle-float

    riverctl map normal Super F1 spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    riverctl map normal Super F2 spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    riverctl map normal Super F3 spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"

    # Focus
    riverctl map normal Super H focus-view left
    riverctl map normal Super J focus-view down
    riverctl map normal Super K focus-view up
    riverctl map normal Super L focus-view right
    riverctl map normal Super Left focus-view left
    riverctl map normal Super Down focus-view down
    riverctl map normal Super Up focus-view up
    riverctl map normal Super Right focus-view right

    # Swap
    riverctl map normal Super+Shift H swap left
    riverctl map normal Super+Shift J swap down
    riverctl map normal Super+Shift K swap up
    riverctl map normal Super+Shift L swap right
    riverctl map normal Super+Shift Left swap left
    riverctl map normal Super+Shift Down swap down
    riverctl map normal Super+Shift Up swap up
    riverctl map normal Super+Shift Right swap right

    riverctl map normal Super V spawn "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"
    riverctl map normal Super+Shift X spawn "swaylock -f"

    # Workspaces
    for i in $(seq 1 9); do
      tags=$((1 << ($i - 1)))
      riverctl map normal Super $i set-focused-tags $tags
      riverctl map normal Super+Shift $i set-view-tags $tags
    done
    riverctl map normal Super+Control $i toggle-focused-tags $tags
    riverctl map normal Super+Shift+Control $i toggle-view-tags $tags

    riverctl map normal Super Tab focus-previous-tags


    # Audio
    riverctl map normal None XF86AudioMute spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    riverctl map normal None XF86AudioLowerVolume spawn "pactl set-sink-volume @DEFAULT_SINK@ -11%"
    riverctl map normal None XF86AudioRaiseVolume spawn "pactl set-sink-volume @DEFAULT_SINK@ +11%"

    # Brightness
    riverctl map normal Super Page_Up spawn "ddcutil setvcp 10 + 15"
    riverctl map normal Super Page_Down spawn "ddcutil setvcp 10 - 15"

    # Screenshots
    riverctl map normal Super Z spawn "$HOME/.local/bin/screenshot-capture-wayland.sh"
    riverctl map normal Super+Shift Z spawn "$HOME/.local/bin/screenshot-capture-wayland.sh"

    # Wallpaper
    riverctl map normal Super W spawn "$HOME/.config/river/cycle-wallpaper.sh"

    # File manager
    riverctl map normal Super E spawn nautilus

    # Lock screen
    riverctl map normal Super+Shift L spawn "swaylock -f -c 1a1a2e"

    # Notification dismiss
    riverctl map normal Super N spawn "makoctl dismiss"
    riverctl map normal Super+Shift N spawn "makoctl dismiss --all"

    # Scratchpad toggle (floating terminal)
    riverctl map normal Super grave spawn "alacritty --class scratch"

    # Move views to/from output
    riverctl map normal Super+Shift period send-to-output next
    riverctl map normal Super+Shift comma send-to-output previous

    # ===== RESIZE MODE =====
    riverctl declare-mode resize
    riverctl map normal Super R enter-mode resize
    riverctl map resize None Right send-layout-cmd rivertile "main-ratio +0.05"
    riverctl map resize None Left send-layout-cmd rivertile "main-ratio -0.05"
    riverctl map resize None Up resize-view 0 -50
    riverctl map resize None Down resize-view 0 50
    riverctl map resize None Escape enter-mode normal
    riverctl map resize None Return enter-mode normal

    # Mouse
    riverctl map-pointer normal Super BTN_LEFT move-view
    riverctl map-pointer normal Super BTN_RIGHT resize-view

    # ===== APPEARANCE =====
    riverctl border-width 4
    riverctl border-color-focused 0xCF1358
    riverctl border-color-unfocused 0x4A0030
    riverctl xcursor-theme Adwaita 24
    riverctl focus-follows-cursor normal
    riverctl default-attach-mode bottom

    # ===== Monitor's REfresh rate =====
    riverctl spawn "wlr-randr --output HDMI-A-2 --mode 1280x1024@75.004997"

    # ===== Warm light =====
    riverctl spawn "wlsunset -l 22.84 -L 89.54 -t 4500 -T 6500"

    # ===== Clipbaord =====
    riverctl spawn "wl-paste --watch cliphist store"

    # ===== LAYOUT =====
    riverctl default-layout rivertile
    rivertile -view-padding 5 -outer-padding 4 &
  '';
};


programs.ghostty = {
  enable = true;
  settings = {
    background = "#282828";
    foreground = "#ebdbb2";
    cursor-color = "#c2185b";
    selection-background = "#3c3836";
    selection-foreground = "#ebdbb2";
    font-family = "JetBrainsMono Nerd Font";
    font-size = 13;
    window-padding-x = 12;
    window-padding-y = 12;
    gtk-titlebar = false;
    gtk-single-instance = true;
  };
};








home.file.".config/waybar/config.jsonc" = {
  text = ''
    {
      "reload_style_on_change": true,
      "layer": "top",
      "position": "top",
      "spacing": 0,
      "height": 26,
      "modules-left": ["river/tags"],
      "modules-center": ["clock"],
      "modules-right": [
        "custom/screenshot",
        "group/tray-expander",
        "bluetooth",
        "network",
        "pulseaudio",
        "cpu",
        "memory"
      ],
      "river/tags": {
        "num-tags": 9,
        "tag-labels": ["1","2","3","4","5","6","7","8","9"]
      },
      "clock": {
        "format": "{:%A %H:%M}",
        "format-alt": "{:%d %B W%V %Y}",
        "tooltip": false
      },
      "cpu": {
        "interval": 5,
        "format": "󰍛",
        "on-click": "alacritty -e btop"
      },
      "memory": {
        "interval": 5,
        "format": "󰾆",
        "tooltip-format": "{used:0.1f}G / {total:0.1f}G"
      },
      "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-muted": "󰝟 muted",
        "scroll-step": 5,
        "on-click": "alacritty -e wiremix",
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
        "on-click": "alacritty -e nmtui"
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
      font-size: 12px;
      font-weight: 600;
      min-height: 0;
      border: none;
      border-radius: 0;
    }
    window#waybar {
      background-color: #fef9f0;
      color: #0a0a0a;
      border-bottom: 2px solid #c2185b;
    }
    .modules-left {
      margin-left: 8px;
    }
    .modules-right {
      margin-right: 8px;
    }
    #tags button {
      all: initial;
      font-family: 'JetBrainsMono Nerd Font';
      font-size: 12px;
      font-weight: 600;
      padding: 0 6px;
      margin: 0 1.5px;
      min-width: 9px;
      color: #888;
    }
    #tags button.focused {
      color: #fef9f0;
      background-color: #c2185b;
    }
    #tags button.occupied {
      color: #c2185b;
    }
    #tags button.urgent {
      color: #fef9f0;
      background-color: #880e4f;
    }
    #clock {
      color: #0a0a0a;
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
      color: #0a0a0a;
    }
    #tray {
      margin-right: 16px;
    }
    #bluetooth {
      margin-right: 17px;
    }
    #network {
      margin-right: 13px;
    }
    #custom-expand-icon {
      margin-right: 18px;
    }
    .tray-group-item {
      margin: 0 4px;
    }
    #pulseaudio.muted {
      color: #c2185b;
    }
    #network.disconnected {
      color: #c2185b;
    }
    #bluetooth.off {
      color: #bbb;
    }
    #custom-screenshot {
      margin: 0 7.5px;
      color: #0a0a0a;
    }
    #custom-screenshot:hover {
      color: #c2185b;
    }
    tooltip {
      padding: 2px;
    }
  '';
};



home.file.".config/fastfetch/config.jsonc" = {
  text = ''
    {
      "display": {
        "separator": " : "
      },
     "modules": [
        "break",
        {
          "type": "custom",
          "format": "\u001b[90m┌──────────────────────Hardware──────────────────────┐"
        },
        {
          "type": "host",
          "key": " PC",
          "keyColor": "green"
        },
        {
          "type": "cpu",
          "key": "│ ├",
          "showPeCoreCount": true,
          "keyColor": "green"
        },
        {
          "type": "gpu",
          "key": "│ ├",
          "detectionMethod": "pci",
          "keyColor": "green"
        },
        {
          "type": "display",
          "key": "│ ├󱄄",
          "keyColor": "green"
        },
        {
          "type": "disk",
          "key": "│ ├󰋊",
          "keyColor": "green"
        },
        {
          "type": "memory",
          "key": "│ ├",
          "keyColor": "green"
        },
        {
          "type": "swap",
          "key": "└ └󰓡 ",
          "keyColor": "green"
        },
        {
          "type": "custom",
          "format": "\u001b[90m└────────────────────────────────────────────────────┘"
        },
        "break",
        {
          "type": "custom",
          "format": "\u001b[90m┌──────────────────────Software──────────────────────┐"
        },
        {
          "type": "command",
          "key": "\ue900 OS",
          "keyColor": "blue",
          "text": "version=$(nixos-version); echo \"nixos $version\""
        },
        {
          "type": "command",
          "key": "│ ├󰘬",
          "keyColor": "blue",
          "text": "branch=$(nixos-version-branch); echo \"$branch\""
        },
        {
          "type": "command",
          "key": "│ ├󰔫",
          "keyColor": "blue",
          "text": "channel=$(nixos-version-channel); echo \"$channel\""
        },
        {
          "type": "kernel",
          "key": "│ ├",
          "keyColor": "blue"
        },
        {
          "type": "wm",
          "key": "│ ├",
          "keyColor": "blue"
        },
        {
          "type": "de",
          "key": " DE",
          "keyColor": "blue"
        },
        {
          "type": "terminal",
          "key": "│ ├",
          "keyColor": "blue"
        },
        {
          "type": "packages",
          "key": "│ ├󰏖",
          "keyColor": "blue"
        },
        {
          "type": "wmtheme",
          "key": "│ ├󰉼",
          "keyColor": "blue"
        },
        {
          "type": "command",
          "key": "│ ├󰸌",
          "keyColor": "blue",
          "text": "theme=$(nixos-theme-current); echo -e \"$theme \\e[38m●\\e[37m●\\e[36m●\\e[35m●\\e[34m●\\e[33m●\\e[32m●\\e[31m●\""
        },
        {
          "type": "terminalfont",
          "key": "└ └",
          "keyColor": "blue"
        },
        {
          "type": "custom",
          "format": "\u001b[90m└────────────────────────────────────────────────────┘"
        },
        "break",
        {
          "type": "custom",
          "format": "\u001b[90m┌────────────────Age / Uptime / Update───────────────┐"
        },
        {
          "type": "command",
          "key": "󱦟 OS Age",
          "keyColor": "magenta",
          "text": "echo $(( ($(date +%s) - $(stat -c %W /)) / 86400 )) days"
        },
        {
          "type": "uptime",
          "key": "󱫐 Uptime",
          "keyColor": "magenta"
        },
        {
          "type": "command",
          "key": " Update",
          "keyColor": "magenta",
          "text": "updated=$(nixos-version-pkgs); echo \"$updated\""
        },
        {
          "type": "custom",
          "format": "\u001b[90m└────────────────────────────────────────────────────┘"
        },
        "break"
      ]
    }
  '';
};






home.file.".local/bin/screenshot-capture-wayland.sh" = {
  executable = true;
  text = ''
    #!/bin/bash
    SCREENSHOT_DIR="$HOME/dirrr"
    LOCKFILE="$HOME/.ss_counter.lock"
    # Create directory if it doesn't exist
    mkdir -p "$SCREENSHOT_DIR"
    # Get exclusive lock
    exec 200>"$LOCKFILE"
    flock 200
    # Find next available number by checking what exists
    n=1
    while [ -f "$SCREENSHOT_DIR/ss$n.png" ]; do
      n=$((n + 1))
    done
    # Take screenshot
    if [ "$1" = "region" ]; then
      grim -g "$(slurp)" "$SCREENSHOT_DIR/ss$n.png"
    else
      grim "$SCREENSHOT_DIR/ss$n.png"
    fi
  '';
};



home.file.".config/yazi/yazi.toml" = {
  text = ''
    [mgr]
    show_hidden = true

    [[opener.browser]]
    run = 'firefox "$@"'
    orphan = true
    desc = "Open in Firefox"
    for = "unix"

    [[open.prepend_rules]]
    mime = "text/html"
    use = "browser"

    [[open.prepend_rules]]
    mime = "application/xhtml+xml"
    use = "browser"



    [opener]
    edit = [
        { run = 'nvim "$@"', block = true, for = "unix" },
    ]
    open = [
        { run = 'xdg-open "$@"', desc = "Open", for = "unix" },
    ]
    image = [
        { run = 'imv "$@"', orphan = true, for = "unix" },
    ]
    play_audio = [
        { run = 'killall -q mpv; mpv --force-window --no-resume-playback "$@"', desc = "Play Audio" }
    ]
    [open]
    rules = [
        { mime = "audio/*", use = "play_audio" },
        { mime = "image/*", use = "image" },
        { mime = "text/*", use = "edit" },
        { mime = "video/*", use = [ "open" ] },
    ]
  '';
};













}
