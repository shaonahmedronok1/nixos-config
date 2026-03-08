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







wayland.windowManager.hyprland = {
  enable = true;
  systemd.enable = true;

  settings = {
    "$mod" = "SUPER";

    monitor = ",preferred,auto,1";

    env = [
      "NIXOS_OZONE_WL,1"
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_QPA_PLATFORM,wayland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    ];

    exec-once = [
      "waybar"
      "mako"
      "udiskie -t"
      "wlsunset -l 22.84 -L 89.54 -t 4500 -T 6500"
      "wl-paste --watch cliphist store"
      "wl-clip-persist --clipboard regular"
      "swayidle -w timeout 300 'swaylock -f' timeout 600 'systemctl suspend' before-sleep 'swaylock -f'"
      "wlr-randr --output HDMI-A-2 --mode 1280x1024@75.004997"
      "swww-daemon"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 4;
      "col.active_border" = "rgba(00CED9ff)";
      "col.inactive_border" = "rgba(4A0030ff)";
      layout = "dwindle";
    };

    decoration = {
      rounding = 8;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
    };

    input = {
      kb_layout = "us";
      follow_mouse = 1;
      repeat_rate = 50;
      repeat_delay = 300;
      touchpad.natural_scroll = false;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    bind = [
      # Terminal
      "$mod, Return, exec, alacritty"
      "$mod, grave, exec, alacritty"

      

      "$mod, period, exec, cat ~/.config/.emoji | fuzzel --dmenu | awk '{print $1}' | wl-copy && wtype -M ctrl v"
      


      # Apps
      "$mod, Space, exec, fuzzel"
      "$mod, B, exec, chromium"
      "$mod, E, exec, nautilus"

      # Window management
      "$mod, C, killactive"
      "$mod SHIFT, E, exit"
      "$mod, F, fullscreen"
      "$mod SHIFT, Space, togglefloating"

      # Clipboard
      "$mod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"

      # Lock
      "$mod SHIFT, X, exec, swaylock -f"
      "$mod SHIFT, L, exec, swaylock -f -c 1a1a2e"

      # Notifications
      "$mod, N, exec, makoctl dismiss"
      "$mod SHIFT, N, exec, makoctl dismiss --all"

      # Screenshot
      "$mod, Z, exec, bash ~/.local/bin/screenshot-capture-wayland.sh region"
      "$mod SHIFT, Z, exec, bash ~/.local/bin/screenshot-capture-wayland.sh"

      # Wallpaper
      "$mod, W, exec, bash ~/.config/river/cycle-wallpaper.sh"

      # Focus
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"
      "$mod, left, movefocus, l"
      "$mod, down, movefocus, d"
      "$mod, up, movefocus, u"
      "$mod, right, movefocus, r"

      # Move windows
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, J, movewindow, d"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, L, movewindow, r"
      "$mod SHIFT, left, movewindow, l"
      "$mod SHIFT, down, movewindow, d"
      "$mod SHIFT, up, movewindow, u"
      "$mod SHIFT, right, movewindow, r"

      # Workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"

      # Move to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"

      # Move to next/prev monitor
      "$mod SHIFT, period, movewindow, mon+1"
      "$mod SHIFT, comma, movewindow, mon-1"

      # Volume
      ", XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -11%"
      ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +11%"
      "$mod, F1, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
      "$mod, F2, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
      "$mod, F3, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"

      # Brightness
      "$mod, Page_Up, exec, ddcutil setvcp 10 + 15"
      "$mod, Page_Down, exec, ddcutil setvcp 10 - 15"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
};






programs.alacritty = {
  enable = true;
  settings = {
    window.padding = { x = 10; y = 10; };
    window.opacity = 1.0;
    cursor.style = "Block";
    font = {
      normal.family = "JetBrainsMono Nerd Font";
      size = 17;
    };
    colors = {
      primary = {
        background = "#242424";
        foreground = "#fbf1c7";
      };
      cursor = {
        text = "#242424";
        cursor = "#fbf1c7";
      };
      selection = {
        text = "#504945";
        background = "#3c3836";
      };
    };
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
      "modules-left": ["hyprland/workspaces"],
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
    #workspaces button {
      all: initial;
      font-family: 'JetBrainsMono Nerd Font';
      font-size: 12px;
      font-weight: 600;
      padding: 0 6px;
      margin: 0 1.5px;
      min-width: 9px;
      color: #888;
    }
    #workspaces button.active {
      color: #fef9f0;
      background-color: #c2185b;
    }
    #workspaces button.nonempty {
      color: #c2185b;
    }
    #workspaces button.urgent {
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






home.file.".config/.emoji".text = ''
  🔥 fire hot
  💯 hundred perfect
  ✨ sparkles magic
  💙 blue heart
  🤍 white heart
  ⚡ lightning fast energy
  🌙 moon night
  ☀️ sun bright day
  🍁 maple leaf nature plant vegetable ca fall
  🦀 crab animal crustacean
  🦞 lobster animal nature bisque claws seafood
  🦐 shrimp animal ocean nature seafood
  ❄️ snowflake winter season cold weather christmas xmas
  ✨ sparkles stars shine shiny cool awesome good magic
  📚 books literature library study
  ✏️ pencil stationery write paper writing school study
  ✒️ black nib pen stationery writing write
  🖋️ fountain pen stationery writing write
  🖊️ pen stationery writing write
  🖌️ paintbrush drawing creativity art
  🖍️ crayon drawing creativity
  🧬 dna biologist genetics life
  ⚛️ atom symbol science physics chemistry
  🪸 coral ocean sea reef
  🪷 lotus flower calm meditation
  🫧 bubbles soap fun carbonation sparkling
  🍫 chocolate bar food snack dessert sweet
  🍕 pizza food party
  🌭 hot dog food frankfurter
  🥦 broccoli fruit food vegetable
  🍞 bread food wheat breakfast toast
  🥐 croissant food bread french
  🥖 baguette bread food bread french
  🥪 sandwich food lunch bread
  🥗 green salad food healthy lettuce
  🍿 popcorn food movie theater films snack
  🍝 spaghetti food italian noodle
  🌺 hibiscus plant vegetable flowers beach
  🦩 flamingo animal
  🦉 owl animal nature bird hoot
  🐧 penguin animal nature
  🐼 panda animal nature panda
  🤝 handshake agreement shake
  💢 anger symbol angry mad
  💮 white flower japanese spring
  🌸 cherry blossom flower
'';


















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
