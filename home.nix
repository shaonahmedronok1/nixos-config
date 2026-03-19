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
    safe.directory = "/etc/nixos";
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
      "hyprlock"
      #"swayidle -w timeout 300 'swaylock -f' timeout 600 'systemctl suspend' before-sleep 'swaylock -f'"
      "wlr-randr --output HDMI-A-2 --mode 1280x1024@75.004997"
      "swww-daemon"
    ];

    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 4;
      "col.active_border" = "rgba(00CED9ff) rgba(00fff5cc) 45deg";
      "col.inactive_border" = "rgba(4A0030ff)";
      layout = "dwindle";
      resize_on_border = true;          # NEW — resize by dragging any window edge
    };

    decoration = {
      rounding = 8;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
      active_opacity = 1.0;             # NEW
      inactive_opacity = 0.95;          # NEW
      shadow = {                        # NEW — shadow moved to sub-block in current Hyprland
        enabled = true;
        range = 8;
        render_power = 2;
        "color" = "rgba(00CED9bb)";
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

    # ── NEW: animations ───────────────────────────────────────────────────────
    animations = {
      enabled = true;
      bezier = [
        "ease, 0.4, 0.0, 0.2, 1.0"
      ];
      animation = [
        "windows,    1, 4, ease, popin 80%"
        "windowsOut, 1, 4, ease, popin 80%"
        "border,     1, 5, ease"
        "fade,       1, 4, ease"
        "workspaces, 1, 5, ease, slide"
      ];
    };

    # ── NEW: misc ─────────────────────────────────────────────────────────────
    misc = {
      disable_hyprland_logo    = true;
      disable_splash_rendering = true;
      force_default_wallpaper  = 0;
    };

    # ── NEW: cursor ───────────────────────────────────────────────────────────
    cursor = {
      no_hardware_cursors = false;
    };

    # ── NEW: windowrulev2 ─────────────────────────────────────────────────────
    windowrulev2 = [
      "float, class:^(pavucontrol)$"
      "float, class:^(nm-connection-editor)$"
      "float, title:^(File Operation Progress)$"
      "float, title:^(Confirm to replace files)$"
      "float, class:^(xdg-desktop-portal-gtk)$"
      "float, class:^(imv)$"
      "size 900 600, class:^(pavucontrol)$"
      "center, class:^(pavucontrol)$"
    ];

    bind = [
      # Terminal
      "$mod, Return, exec, kitty"
      "$mod, grave, exec, kitty"

      

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
      #"$mod SHIFT, X, exec, swaylock -f"
      #"$mod SHIFT, L, exec, swaylock -f -c 1a1a2e"
      
      "$mod SHIFT, X, exec, hyprlock"
      "$mod SHIFT, L, exec, hyprlock"



      # Notifications
      "$mod, N, exec, makoctl dismiss"
      "$mod SHIFT, N, exec, makoctl dismiss --all"

      # Screenshot
      "$mod, Z, exec, bash ~/.local/bin/screenshot-capture-wayland.sh region"
      "$mod SHIFT, Z, exec, bash ~/.local/bin/screenshot-capture-wayland.sh"

      # Wallpaper
      "$mod, W, exec, bash ~/.config/hypr/cycle-wallpaper.sh"

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






home.file.".config/hypr/cycle-wallpaper.sh" = {
  executable = true;
  text = ''
    #!/bin/bash
    WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.gif" \) | shuf -n 1)
    swww img "$WALLPAPER" --transition-type fade --transition-duration 1
  '';
};



programs.atuin = {
  enable = true;
  settings = {
    filter_mode_shell_up_arrow_history = "global";
  };
};






services.hypridle = {
  enable = true;
  settings = {
    general = {
      lock_cmd = "pidof hyprlock || hyprlock";
      before_sleep_cmd = "loginctl lock-session";
      after_sleep_cmd = "hyprctl dispatch dpms on";
    };
    listener = [
      {
        timeout = 300;
        on-timeout = "loginctl lock-session";
      }
      {
        timeout = 600;
        on-timeout = "systemctl suspend";
      }
    ];
  };
};

programs.hyprlock = {
  enable = true;
  settings = {
    general = {
      hide_cursor = true;
      ignore_empty_input = true;
    };
    background = [{
      path = "screenshot";
      blur_passes = 3;
      blur_size = 8;
      brightness = 0.8;
      contrast = 0.9;
    }];
    input-field = [{
      size = "250, 55";
      position = "0, -80";
      monitor = "";
      dots_center = true;
      fade_on_empty = false;
      outline_thickness = 3;
      outer_color = "rgb(c2185b)";
      inner_color = "rgb(0d0d0d)";
      font_color = "rgb(fef9f0)";
      placeholder_text = "<i>Password...</i>";
      shadow_passes = 2;
      halign = "center";
      valign = "center";
    }];
    label = [{
      text = "$TIME";
      color = "rgba(fef9f0ff)";
      font_size = 52;
      font_family = "JetBrainsMono Nerd Font";
      position = "0, 80";
      halign = "center";
      valign = "center";
    }];
  };
};

















home.file.".config/VSCodium/User/settings.json".text = ''
  {
    "workbench.colorTheme": "Gruvbox Dark Hard",
    "editor.fontFamily": "JetBrainsMono Nerd Font",
    "editor.fontSize": 14,
    "editor.fontLigatures": true,
    "workbench.colorCustomizations": {
      "[Gruvbox Dark Hard]": {
        "editor.background": "#0d0d0d",
        "terminal.background": "#0d0d0d",
        "sideBar.background": "#0d0d0d",
        "activityBar.background": "#0d0d0d",
        "statusBar.background": "#1d2021",
        "titleBar.activeBackground": "#0d0d0d",
        "panel.background": "#0d0d0d"
      }
    }
  }
'';






programs.kitty = {
  enable = true;
  settings = {
    window_padding_width = 10;
    background_opacity   = "0.92";
    cursor_shape         = "block";
    font_family          = "JetBrainsMono Nerd Font";
    font_size            = 17;

    background           = "#0d0d0d";
    foreground           = "#ebdbb2";
    cursor               = "#d4956a";
    cursor_text_color    = "#0d0d0d";
    selection_foreground = "#0d0d0d";
    selection_background = "#d4956a";

    # black
    color0  = "#1d2021";
    color8  = "#504945";
    # red
    color1  = "#cc241d";
    color9  = "#fb4934";
    # green / lime
    color2  = "#98971a";
    color10 = "#b8bb26";
    # yellow
    color3  = "#d79921";
    color11 = "#fabd2f";
    # blue
    color4  = "#458588";
    color12 = "#83a598";
    # magenta
    color5  = "#b16286";
    color13 = "#d3869b";
    # teal/cyan — the soft blue you see on booleans
    color6  = "#689d6a";
    color14 = "#8ec07c";
    # white
    color7  = "#a89984";
    color15 = "#ebdbb2";
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



#programs.swaylock = {
 # enable = true;
 # settings = {
 #   color = "fef9f0";
 #   ring-color = "c2185b";
 #   inside-color = "fef9f0";
 #   text-color = "0a0a0a";
 #   indicator-radius = 80;
 # };
#};





programs.imv = {
  enable = true;
  settings = {
    binds = {
      "<Ctrl+p>"       = ''exec lp "$imv_current_file"'';
      "<Ctrl+x>"       = ''exec rm "$imv_current_file"; quit'';
      "<Ctrl+Shift+X>" = ''exec rm "$imv_current_file"; close'';
      "<Ctrl+r>"       = ''exec mogrify -rotate 90 "$imv_current_file"'';
    };
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
        "on-click": "kitty -e btop"
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











home.file.".config/nvim/lua/plugins/colorscheme.lua".text = ''
  return {
    {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      opts = {
        contrast = "hard",
        overrides = {
          Normal         = { bg = "#0d0d0d" },
          NormalNC       = { bg = "#0d0d0d" },
          SignColumn     = { bg = "#0d0d0d" },
          EndOfBuffer    = { bg = "#0d0d0d" },
          NormalFloat    = { bg = "#0d0d0d" },
          Boolean        = { fg = "#83a598", bg = "NONE" },
          Number         = { fg = "#83a598", bg = "NONE" },
          Float          = { fg = "#83a598", bg = "NONE" },
          String         = { fg = "#b8bb26", bg = "NONE" },
          ["@string"]    = { fg = "#b8bb26" },
          ["@number"]    = { fg = "#83a598" },
          ["@boolean"]   = { fg = "#83a598" },
          ["@field"]     = { fg = "#d4956a" },
          ["@property"]  = { fg = "#d4956a" },
          ["@attribute"] = { fg = "#d4956a" },
        },
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "gruvbox",
      },
    },
  }
'';













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
    open_pdf = [
        { run = 'evince "$@"', orphan = true, desc = "Open PDF", for = "unix" },
    ]
    [[opener.browser]]
    run = 'firefox "$@"'
    orphan = true
    desc = "Open in Firefox"
    for = "unix"
    [open]
    rules = [
        { mime = "audio/*", use = "play_audio" },
        { mime = "image/*", use = "image" },
        { mime = "text/*", use = "edit" },
        { mime = "video/*", use = [ "open" ] },
        { mime = "application/pdf", use = "open_pdf" },
    ]
    [[open.prepend_rules]]
    mime = "text/html"
    use = "browser"
    [[open.prepend_rules]]
    mime = "application/xhtml+xml"
    use = "browser"
  '';
};
home.file.".config/yazi/theme.toml".text = ''
  [manager]
  cwd = { fg = "#b8bb26", bold = true }
  hovered         = { fg = "#0d0d0d", bg = "#b8bb26" }
  preview_hovered = { underline = true }
  find_keyword  = { fg = "#b8bb26", bold = true }
  find_position = { fg = "#d4956a", bg = "reset", bold = true }
  marker_copied   = { fg = "#b8bb26", bg = "#b8bb26" }
  marker_cut      = { fg = "#fb4934", bg = "#fb4934" }
  marker_selected = { fg = "#83a598", bg = "#83a598" }
  tab_active   = { fg = "#0d0d0d", bg = "#b8bb26", bold = true }
  tab_inactive = { fg = "#a89984", bg = "#1d2021" }
  tab_width    = 1
  count_copied   = { fg = "#0d0d0d", bg = "#b8bb26" }
  count_cut      = { fg = "#0d0d0d", bg = "#fb4934" }
  count_selected = { fg = "#0d0d0d", bg = "#83a598" }
  border_symbol = "│"
  border_style  = { fg = "#504945" }
  [status]
  separator_open  = ""
  separator_close = ""
  separator_style = { fg = "#1d2021", bg = "#1d2021" }
  mode_normal = { fg = "#0d0d0d", bg = "#b8bb26", bold = true }
  mode_select = { fg = "#0d0d0d", bg = "#b8bb26", bold = true }
  mode_unset  = { fg = "#0d0d0d", bg = "#83a598", bold = true }
  progress_label  = { fg = "#ebdbb2", bold = true }
  progress_normal = { fg = "#83a598", bg = "#1d2021" }
  progress_error  = { fg = "#fb4934", bg = "#1d2021" }
  permissions_t = { fg = "#d4956a" }
  permissions_r = { fg = "#b8bb26" }
  permissions_w = { fg = "#fb4934" }
  permissions_x = { fg = "#83a598" }
  permissions_s = { fg = "#504945" }
  [input]
  border   = { fg = "#d4956a" }
  title    = {}
  value    = {}
  selected = { reversed = true }
  [select]
  border   = { fg = "#d4956a" }
  active   = { fg = "#b8bb26", bold = true }
  inactive = {}
  [tasks]
  border  = { fg = "#d4956a" }
  title   = {}
  hovered = { underline = true }
  [which]
  cols            = 3
  mask            = { bg = "#1d2021" }
  cand            = { fg = "#b8bb26" }
  rest            = { fg = "#504945" }
  desc            = { fg = "#ebdbb2" }
  separator       = "  "
  separator_style = { fg = "#504945" }
  [notify]
  title_info  = { fg = "#b8bb26" }
  title_warn  = { fg = "#fabd2f" }
  title_error = { fg = "#fb4934" }
  [filetype]
  rules = [
    { mime = "image/*",         fg = "#83a598" },
    { mime = "video/*",         fg = "#d4956a" },
    { mime = "audio/*",         fg = "#b8bb26" },
    { mime = "text/*",          fg = "#ebdbb2" },
    { mime = "inode/directory", fg = "#d4956a", bold = true },
    { name = "*.nix",           fg = "#83a598" },
    { name = "*.rs",            fg = "#d4956a" },
    { name = "*.py",            fg = "#fabd2f" },
    { name = "*.sh",            fg = "#b8bb26" },
    { name = "*.md",            fg = "#ebdbb2" },
    { name = "*.toml",          fg = "#d4956a" },
    { name = "*.json",          fg = "#fabd2f" },
  ]
'';





home.file.".config/nvim/lua/plugins/lsp.lua".text = ''
  return {
    {
      "mason-org/mason.nvim",
      opts = {
        ensure_installed = {
          "pyright",
          "ruff-lsp",
          "html-lsp",
          "css-lsp",
          "typescript-language-server",
          "prettier",
          "eslint-lsp",
        },
      },
    },
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          pyright = {},
          ruff_lsp = {},
          html = {},
          cssls = {},
          tsserver = {},
        },
      },
    },
  }
'';































}
