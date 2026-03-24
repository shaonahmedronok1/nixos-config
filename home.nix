{ config, pkgs, ... }:

{
  home.username = "az";
  home.homeDirectory = "/home/az";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    initExtra = ""; # <--- EMPTY! Clean and perfect.
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
  enableBashIntegration = true; # Move this OUTSIDE settings
  settings = {
    add_newline = false;
 
      # --- Vimjoyer 1 Trillion Percent Perfect Prompt ---
      character = {
        # Changed pink to base0B (Green) for success
        success_symbol = "[❯](bold #b8bb26)"; 
        # Changed "red" to the exact base08 (Red) from your palette
        error_symbol = "[❯](bold #fb4934)";   
      };

      # --- Functional Settings (Kept exactly as is) ---
      nix_shell.symbol = " ";
      git_branch.symbol = " ";
      directory.truncation_length = 3;

      # Extra Perfection: Make the directory color match the theme foreground
      directory = {
        style = "bold #ebdbb2"; # base06
      };
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



# --- THE SMART STUFF ---
  programs.zoxide.enable = true;
  programs.zoxide.enableBashIntegration = true;

  programs.fzf.enable = true;
  programs.fzf.enableBashIntegration = true;

  programs.eza.enable = true;
  programs.eza.enableBashIntegration = true;

  programs.bat.enable = true;
  programs.bat.config.theme = "gruvbox-dark";


programs.btop = {
    enable = true;
    settings = {
      # --- The Vimjoyer Color Engine ---
      color_theme = "tty";          # Vital: Let your terminal colors take over
      theme_background = false;     # Transparent background
      truecolor = true;
      force_tty = false;

      # --- Manual Hex Colors (Vimjoyer Palette) ---
      # Matches Starship: #b8bb26 (Success) and #fb4934 (Error)
      low_gradient_color = "#b8bb26";  # Green
      mid_gradient_color = "#fabd2f";  # Yellow
      high_gradient_color = "#fb4934"; # Red
      
      # --- Your Specific Layout & UI ---
      shown_boxes = "cpu net proc";
      update_ms = 2000;
      presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "braille";
      proc_sorting = "cpu lazy";
      proc_colors = true;
      proc_gradient = true;
      proc_mem_bytes = true;
      proc_cpu_graphs = true;
      base_10_sizes = true; # Technical accuracy: KB = 1000
    };
  };




programs.mpv = {
    enable = true;
    
    # --- The Performance & Logic Engine ---
    config = {
      # --- Low-Spec Intel HD 530 Optimization ---
      profile = "fast";
      vo = "gpu";
      hwdec = "vaapi";
      gpu-api = "opengl";
      
      # --- Functional Logic ---
      save-position-on-quit = true;
      osc = false;
      border = false;
      cursor-autohide = 1000;

      # --- Language & yt-dlp Subtitle Automation ---
      slang = "en,eng,enUS,enGB,enAU,enNZ,enCA,enIE,enZA";
      ytdl-raw-options = "ignore-config=,sub-langs=\"en.*,^en\",write-subs=,write-auto-subs=";

      # --- Official Subtitle Styling (Vimjoyer Visuals) ---
      sub-visibility = "yes";
      sub-auto = "fuzzy";
      sub-font = "JetBrainsMono Nerd Font Mono";
      sub-font-size = 33;
      sub-color = "#ebdbb2";        # base06 (Vimjoyer FG - Better than pure #FFFFFF)
      sub-border-size = 3;
      sub-border-color = "#242424"; # base00 (Vimjoyer BG - Better than pure #000000)
      sub-shadow-offset = 1;
      sub-shadow-color = "#24242440"; # base00 with 40% alpha
      sub-pos = 98;
      sub-align-y = "bottom";
      sub-margin-y = 20;

      # --- OSD Styling (Matches your Terminal) ---
      osd-font = "JetBrainsMono Nerd Font";
      osd-font-size = 28;
      osd-color = "#ebdbb2";        # base06
      osd-border-color = "#242424"; # base00
    };


# --- The Home-Row Control Center ---
    bindings = {
      # --- Nav & Volume ---
      "l" = "seek 5";
      "h" = "seek -5";
      "k" = "add volume 2";
      "j" = "add volume -2";
      
      # --- Playback Controls ---
      "f" = "cycle fullscreen";
      "SPACE" = "cycle pause";
      "s" = "screenshot";
      "S" = "cycle sub";
      "v" = "cycle sub-visibility";

      # --- Precision Speed Controls (0.1 Steps) ---
      "]" = "add speed 0.1";        # 1.1, 1.2, 1.3...
      "[" = "add speed -0.1";       # ...down to 0.1
      "BS" = "set speed 1.0";       # Backspace: Reset to normal speed
      
      # --- System Controls ---
      "q" = "quit";
      "Q" = "quit-watch-later";     # Force save and quit
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
      "hyprsunset -t 4500"
      #"wlsunset -l 22.84 -L 89.54 -t 4500 -T 6500"
      "wl-paste --watch cliphist store"
      "wl-clip-persist --clipboard regular"
      #"hyprlock"
      #"swayidle -w timeout 300 'swaylock -f' timeout 600 'systemctl suspend' before-sleep 'swaylock -f'"
      "wlr-randr --output HDMI-A-2 --mode 1280x1024@75.004997"
      "swww-daemon"
    ];

    general = {
      gaps_in = 0;
      gaps_out = 0;
      border_size = 4;
      
      # --- Vimjoyer 1 Trillion Percent Perfect Gradient ---
      # Logic: Gradient from base0D (Blue) to base0B (Green) at 45 degrees
      "col.active_border" = "rgba(b8bb26ff) rgba(b8bb26ff) 45deg";
      
      # Logic: base01 (Dark Grey) for inactive windows
      "col.inactive_border" = "rgba(3c3836ff)";
      
      layout = "dwindle";
      resize_on_border = true;
    };

    decoration = {
      rounding = 8;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
      active_opacity = 1.0;
      inactive_opacity = 0.95;
      
      shadow = {
        enabled = true;
        range = 8;
        render_power = 2;
        # Logic: Dark shadow (base00) with transparency for a clean depth effect
        "color" = "rgba(242424bb)"; 
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
      "$mod, B, exec, google-chrome-stable"
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
  enableBashIntegration = true; # Move this OUTSIDE settings
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

      # --- Vimjoyer 1 Trillion Percent Colors ---
      outer_color = "rgb(b8bb26)"; # base0B (Lime Border)
      inner_color = "rgb(242424)"; # base00 (Deep Charcoal BG)
      font_color = "rgb(ebdbb2)";  # base06 (Gruvbox Cream Text)
      
      placeholder_text = "<i>Password...</i>";
      shadow_passes = 2;
      halign = "center";
      valign = "center";
    }];
    label = [{
      text = "$TIME";
      
      # Matched the clock color to the Cream foreground for readability
      color = "rgba(ebdbb2ff)";
      
      font_size = 52;
      font_family = "JetBrainsMono Nerd Font";
      position = "0, 80";
      halign = "center";
      valign = "center";
    }];
  };
};





# --- THE VIMJOYER SKIN (Unified & Official) ---
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Green-Dark-Medium";
      package = pkgs.gruvbox-gtk-theme.override {
        colorVariants = ["dark"];
        themeVariants = ["green"];
        tweakVariants = ["medium" "macos"];
      };
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
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
      # --- Functional Settings (Kept exactly as is) ---
      window_padding_width = 10;
      background_opacity   = "1.0";
      cursor_shape         = "block";
      font_family          = "JetBrainsMono Nerd Font";
      font_size            = 16;
      cursor_trail         = 3;

      # --- Vimjoyer Colors (Blindly following Base16 logic) ---
      background           = "#242424"; # base00
      foreground           = "#ebdbb2"; # base06
      cursor               = "#ebdbb2"; # base06
      cursor_text_color    = "#242424"; # base00
      
      selection_background = "#504945"; # base02
      selection_foreground = "#d5c4a1"; # base05

      active_tab_background   = "#242424"; # base00
      active_tab_foreground   = "#ebdbb2"; # base06
      inactive_tab_background = "#3c3836"; # base01
      inactive_tab_foreground = "#665c54"; # base03

      # --- Terminal Colors (0-15) ---
      color0  = "#242424"; # base00
      color8  = "#504945"; # base02
      color1  = "#fb4934"; # base08
      color9  = "#fb4934"; # base08
      color2  = "#b8bb26"; # base0B
      color10 = "#b8bb26"; # base0B
      color3  = "#fabd2f"; # base0A
      color11 = "#fabd2f"; # base0A
      color4  = "#7daea3"; # base0D
      color12 = "#7daea3"; # base0D
      color5  = "#e089a1"; # base0E
      color13 = "#e089a1"; # base0E
      color6  = "#8ec07c"; # base0C
      color14 = "#8ec07c"; # base0C
      color7  = "#ebdbb2"; # base06
      color15 = "#fbf1c7"; # base07
    };
  };










services.mako = {
    enable = true;
    # Moving all colors and sizes into the 'settings' block to stop the warnings
    settings = {
      background-color = "#242424"; # base00
      text-color       = "#ebdbb2"; # base06
      border-color     = "#7daea3"; # base0D
      
      border-size = 2;
      border-radius = 6;
      font = "JetBrainsMono Nerd Font 13";
      width = 400;
      height = 120;
      padding = "12";
      margin = "10";
      default-timeout = 11000;
      ignore-timeout = 0;
      
      # Vimjoyer progress bar logic
      progress-color = "over #242424 #b8bb26";
    };
  };






programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=16";
        lines = 12;
        width = 45;
        terminal = "kitty";
      };
      
      # Using the standard Nix attribute names to ensure zero warnings
      colors = {
        background = "242424ff";     # base00
        text       = "ebdbb2ff";     # base06
        match      = "fb4934ff";     # base08
        selection        = "504945ff"; # base02
        selection-text   = "fbf1c7ff"; # base07
        selection-match  = "fe8019ff"; # base09
        border           = "7daea3ff"; # base0D
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
      # --- Vimjoyer 1 Trillion Percent Perfect Colors ---
      options = {
        background = "242424";      # base00 (Deep charcoal background)
        overlay_text_color = "ebdbb2"; # base06 (Gruvbox cream text)
        overlay_background_color = "3c3836"; # base01 (Dark grey overlay bg)
        overlay_font = "JetBrainsMono Nerd Font:12";
      };

      # --- Functional Settings (Kept exactly as is) ---
      binds = {
        "<Ctrl+p>"       = ''exec lp "$imv_current_file"'';
        "<Ctrl+x>"       = ''exec rm "$imv_current_file"; quit'';
        "<Ctrl+Shift+X>" = ''exec rm "$imv_current_file"; close'';
        "<Ctrl+r>"       = ''exec mogrify -rotate 90 "$imv_current_file"'';
      };
    };
  };







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
      background-color: #242424; /* base00 */
      color: #ebdbb2;           /* base06 */
      border-bottom: 2px solid #7daea3; /* base0D (Blue accent) */
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
      font-size: 13px;
      font-weight: 600;
      padding: 0 4px;
      margin: 0 1.5px;
      min-width: 9px;
      color: #bdae93; /* base04 (Swapped to base04 for visibility) */
      opacity: 0.6;
    }
    #workspaces button.active {
      color: #242424;           /* base00 */
      background-color: #b8bb26; /* base0B (Green for active) */
      opacity: 1.0;
    }
    #workspaces button.nonempty {
      color: #fabd2f;           /* base0A (Yellow for files open) */
      opacity: 1.0;
    }
    #workspaces button.urgent {
      color: #fbf1c7;           /* base07 */
      background-color: #fb4934; /* base08 (Red for urgent) */
      opacity: 1.0;
    }
    #clock {
      color: #ebdbb2;           /* base06 */
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
      color: #d5c4a1;           /* base05 (Lighter foreground) */
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
      color: #fb4934;           /* base08 (Red) */
    }
    #network.disconnected {
      color: #fb4934;           /* base08 (Red) */
    }
    #bluetooth.off {
      color: #504945;           /* base02 (Muted dark) */
    }
    #custom-screenshot {
      margin: 0 7.5px;
      color: #ebdbb2;           /* base06 */
    }
    #custom-screenshot:hover {
      color: #7daea3;           /* base0D (Blue) */
    }
    #custom-media {
      color: #ebdbb2;           /* base06 (Swapped to base06 for Extreme Readability) */
    }
    #custom-media.Paused {
      color: #665c54;           /* base03 */
    }
    #custom-nightlight {
      color: #ebdbb2;           /* base06 */
      margin: 0 7.5px;
    }
    #custom-nightlight:hover {
      color: #fe8019;           /* base09 (Orange) */
    }
    tooltip {
      background-color: #3c3836; /* base01 */
      border: 1px solid #7daea3; /* base0D */
      padding: 2px;
    }
    tooltip label {
      color: #fbf1c7;           /* base07 */
    }
  '';
};













home.file.".config/fastfetch/config.jsonc" = {
  text = ''
    {
      
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "type": "kitty-direct",
    "source": "/home/az/dirrr/ff1.png",
    "width": 32,
    "height": 15,
    "padding": {
      "top": 1,
      "left": 1,
      "right": 4
    }
  },


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
          Normal         = { bg = "#242424" },
          NormalNC       = { bg = "#242424" },
          SignColumn     = { bg = "#242424" },
          EndOfBuffer    = { bg = "#242424" },
          NormalFloat    = { bg = "#242424" },
          Boolean        = { fg = "#e089a1", bg = "NONE" },
          Number         = { fg = "#e089a1", bg = "NONE" },
          Float          = { fg = "#e089a1", bg = "NONE" },
          String         = { fg = "#b8bb26", bg = "NONE", italic = true },
          Function       = { fg = "#b8bb26", bold = true, italic = true },
          Keyword        = { fg = "#fb4934" },
          Type           = { fg = "#fabd2f" },
          Operator       = { fg = "#fe8019" },
          Comment        = { fg = "#665c54", italic = true },
          ["@string"]    = { fg = "#b8bb26", italic = true },
          ["@number"]    = { fg = "#e089a1" },
          ["@boolean"]   = { fg = "#e089a1" },
          ["@function"]  = { fg = "#b8bb26", bold = true, italic = true },
          ["@keyword"]   = { fg = "#fb4934" },
          ["@type"]      = { fg = "#8ec07c", bold = true },
          ["@variable"]  = { fg = "#7daea3" },
          ["@field"]     = { fg = "#fe8019" },
          ["@property"]  = { fg = "#fe8019" },
          ["@attribute"] = { fg = "#fe8019" },
          ["@punctuation"] = { fg = "#fe8019" },
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
  [mgr]
  cwd = { fg = "#b8bb26", bold = true }
  hovered         = { fg = "#242424", bg = "#b8bb26" }
  find_keyword  = { fg = "#b8bb26", bold = true }
  find_position = { fg = "#fe8019", bg = "reset", bold = true }
  marker_copied   = { fg = "#b8bb26", bg = "#b8bb26" }
  marker_cut      = { fg = "#fb4934", bg = "#fb4934" }
  marker_selected = { fg = "#7daea3", bg = "#7daea3" }
  count_copied   = { fg = "#242424", bg = "#b8bb26" }
  count_cut      = { fg = "#242424", bg = "#fb4934" }
  count_selected = { fg = "#242424", bg = "#7daea3" }
  border_symbol = "│"
  border_style  = { fg = "#665c54" }

  [indicator]
  preview = { underline = true }

  [tabs]
  active   = { fg = "#242424", bg = "#b8bb26", bold = true }
  inactive = { fg = "#bdae93", bg = "#3c3836" }

  [status]
  separator_open  = ""
  separator_close = ""
  separator_style = { fg = "#3c3836", bg = "#3c3836" }
  mode_normal = { fg = "#242424", bg = "#b8bb26", bold = true }
  mode_select = { fg = "#242424", bg = "#b8bb26", bold = true }
  mode_unset  = { fg = "#242424", bg = "#7daea3", bold = true }
  progress_label  = { fg = "#ebdbb2", bold = true }
  progress_normal = { fg = "#7daea3", bg = "#3c3836" }
  progress_error  = { fg = "#fb4934", bg = "#3c3836" }
  permissions_t = { fg = "#fe8019" }
  permissions_r = { fg = "#b8bb26" }
  permissions_w = { fg = "#fb4934" }
  permissions_x = { fg = "#7daea3" }
  permissions_s = { fg = "#665c54" }

  [input]
  border   = { fg = "#fe8019" }
  title    = {}
  value    = {}
  selected = { reversed = true }

  [select]
  border   = { fg = "#fe8019" }
  active   = { fg = "#b8bb26", bold = true }
  inactive = {}

  [tasks]
  border  = { fg = "#fe8019" }
  title   = {}
  hovered = { underline = true }

  [which]
  cols            = 3
  mask            = { bg = "#3c3836" }
  cand            = { fg = "#b8bb26" }
  rest            = { fg = "#665c54" }
  desc            = { fg = "#ebdbb2" }
  separator       = "  "
  separator_style = { fg = "#665c54" }

  [notify]
  title_info  = { fg = "#b8bb26" }
  title_warn  = { fg = "#fabd2f" }
  title_error = { fg = "#fb4934" }

  [filetype]
  rules = [
    { mime = "image/*",          fg = "#7daea3" },
    { mime = "video/*",          fg = "#fe8019" },
    { mime = "audio/*",          fg = "#b8bb26" },
    { mime = "text/*",           fg = "#ebdbb2" },
    { mime = "inode/directory",  fg = "#fe8019", bold = true },
    { name = "*.nix",            fg = "#7daea3" },
    { name = "*.rs",             fg = "#fe8019" },
    { name = "*.py",             fg = "#fabd2f" },
    { name = "*.sh",             fg = "#b8bb26" },
    { name = "*.md",             fg = "#ebdbb2" },
    { name = "*.toml",           fg = "#fe8019" },
    { name = "*.json",           fg = "#fabd2f" },
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







home.file.".local/bin/wlsunset-toggle.sh" = {
  executable = true;
  text = ''
  #!/bin/bash
if pgrep -x hyprsunset > /dev/null; then
  pkill hyprsunset
else
  hyprsunset -t 4500 &
fi
pkill -RTMIN+8 waybar
  '';
};























}
