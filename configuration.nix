{ config, pkgs, lib, ... }:
{
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages                  = pkgs.linuxPackages_latest;
  boot.kernelModules                   = [ "i2c-dev" ];

  networking.hostName              = "shaonix";
  networking.networkmanager.enable = true;
  networking.firewall.enable       = true;

  time.timeZone      = "Asia/Dhaka";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.shaonix = {
    isNormalUser = true;
    description  = "shaonix";
    extraGroups  = [ "networkmanager" "wheel" "video" "input" "storage" "i2c" ];
    shell        = pkgs.bash;
  };

  security.pam.services.hyprlock = {};
  security.polkit.enable         = true;
  security.rtkit.enable          = true;

  hardware.graphics = {
    enable        = true;
    extraPackages = [ pkgs.intel-media-driver ];
  };
  hardware.cpu.intel.updateMicrocode = true;
  hardware.i2c.enable                = true;

  services.pipewire = {
    enable             = true;
    alsa.enable        = true;
    pulse.enable       = true;
    wireplumber.enable = true;
  };
  services.pipewire.wireplumber.extraConfig."99-default-sink" = {
    "monitor.alsa.rules" = [{
      matches = [{ "node.name" = "alsa_output.pci-0000_00_1f.3.analog-stereo"; }];
      actions  = { update-props = { "priority.session" = 2000; }; };
    }];
  };

  programs.niri.enable     = true;
  programs.xwayland.enable = true;

  xdg.portal = {
    enable        = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config.niri = {
      default                                   = [ "gnome" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast"  = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot"  = [ "gnome" ];
    };
  };

  services.greetd = {
    enable   = true;
    settings = {
      default_session = {
        user    = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd niri-session";
      };
    };
  };

  services.gvfs.enable                = true;
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable             = true;

  fonts.packages = with pkgs; [
    iosevka
  ];
  fonts.fontconfig.defaultFonts.monospace = [ "Iosevka" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Iosevka" ];

  swapDevices = [{
    device   = "/var/lib/swapfile";
    size     = 8 * 1024;    # 8 GiB in MiB
    priority = 0;            # lower than zram (priority 5) — overflow only
  }];
  zramSwap.enable = true;

  environment.variables.QT_QPA_PLATFORMTHEME = lib.mkForce "gtk2";

  environment.sessionVariables = {
    NIXOS_OZONE_WL                     = "1";
    XDG_CURRENT_DESKTOP                = "niri:GNOME";
    XDG_SESSION_TYPE                   = "wayland";
    XDG_SESSION_DESKTOP                = "niri";
    QT_QPA_PLATFORM                    = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION  = "1";
  };

  environment.systemPackages = with pkgs; [
    adwaita-qt
    nautilus
    adwaita-icon-theme
    git
    firefox
    xwayland-satellite
    qt5.qtwayland
    qt6.qtwayland
    swaybg
    wl-clipboard
    wiremix
    fuzzel
    wireplumber
    pulseaudio
    imagemagick
    slurp
    grim
    wlsunset
    ddcutil
    polkit_gnome
    networkmanagerapplet
    nh
    udiskie
    keepassxc
    imv
    mpv
    zathura
    yazi
  ];

  home-manager.users.shaonix = {
    home.stateVersion = "26.05";
    programs.home-manager.enable = true;

    systemd.user.sessionVariables = {
      GDK_BACKEND                        = "wayland,x11";
    };

    gtk = {
      enable    = true;
      iconTheme = {
        name    = "Gruvbox-Plus-Light";
        package = pkgs.gruvbox-plus-icons;
      };
    };

    qt = {
      enable             = true;
      platformTheme.name = lib.mkForce "gtk";
      style.name         = lib.mkForce "adwaita";
    };

    xdg.desktopEntries.helix = {
      name        = "Helix";
      genericName = "Text Editor";
      exec        = "alacritty -e hx %F";
      terminal    = false;
      categories  = [ "Utility" "TextEditor" ];
      mimeType    = [
        "text/plain" "text/x-nix" "text/markdown"
        "application/json" "text/x-shellscript" "text/x-org"
      ];
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory"                    = [ "org.gnome.Nautilus.desktop" ];
        "application/x-gnome-saved-search" = [ "org.gnome.Nautilus.desktop" ];
        "text/plain"                         = [ "helix.desktop" ];
        "text/x-nix"                         = [ "helix.desktop" ];
        "text/markdown"                      = [ "helix.desktop" ];
        "application/json"                   = [ "helix.desktop" ];
        "text/x-shellscript"                 = [ "helix.desktop" ];
        "text/x-org"                         = [ "helix.desktop" ];
        "application/pdf"                    = [ "zathura.desktop" ];
      };
    };

    xdg.configFile."niri/config.kdl".text = ''
      input {
          keyboard {
              xkb {
                  layout "us"
              }
              repeat-delay 300
              repeat-rate  50
          }
          focus-follows-mouse
      }

      cursor {
          xcursor-theme "Adwaita"
          xcursor-size 24
      }

      output "HDMI-A-2" {
          mode "1280x1024@75"
      }

      layout {
          gaps 6
          center-focused-column "never"
          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }
          default-column-width { proportion 0.5; }
          struts {
              left   8
              right  8
              top    8
              bottom 8
          }
          focus-ring {
              width 3
              active-color   "#458588"
              inactive-color "#D9D3C3"
          }
          border {
              width 3
              active-color   "#458588"
              inactive-color "#D9D3C3"
          }
      }

      prefer-no-csd

      window-rule {
          geometry-corner-radius 8
          clip-to-geometry true
      }
      window-rule {
          match app-id="org.gnome.Nautilus"
          open-floating true
      }
      window-rule {
          match app-id="xdg-desktop-portal-gtk"
          open-floating true
      }
      window-rule {
          match app-id="nm-connection-editor"
          open-floating true
      }
      window-rule {
          match title="File Operation Progress"
          open-floating true
      }
      window-rule {
          match title="Confirm to replace files"
          open-floating true
      }
      window-rule {
          match app-id="imv"
          open-floating true
      }

      spawn-at-startup "udiskie" "-t"
      spawn-at-startup "swaybg" "-i" "/etc/nixos/wallpaper.jpg" "-m" "fill"
      spawn-at-startup "wlsunset" "-t" "4500" "-T" "4500"
      spawn-at-startup "xwayland-satellite"

      binds {
          Mod+Return { spawn "alacritty"; }
          Mod+Space  { spawn "fuzzel"; }
          Mod+B      { spawn "firefox"; }
          Mod+C         { close-window; }
          Mod+F         { maximize-column; }
          Mod+Shift+Space { toggle-window-floating; }
          Mod+H     { focus-column-left; }
          Mod+J     { focus-window-or-workspace-down; }
          Mod+K     { focus-window-or-workspace-up; }
          Mod+L     { focus-column-right; }
          Mod+Left  { focus-column-left; }
          Mod+Down  { focus-window-or-workspace-down; }
          Mod+Up    { focus-window-or-workspace-up; }
          Mod+Right { focus-column-right; }
          Mod+Shift+H      { move-column-left; }
          Mod+Shift+J      { move-window-down-or-to-workspace-down; }
          Mod+Shift+K      { move-window-up-or-to-workspace-up; }
          Mod+Shift+L      { move-column-right; }
          Mod+Shift+Left   { move-column-left; }
          Mod+Shift+Down   { move-window-down-or-to-workspace-down; }
          Mod+Shift+Up     { move-window-up-or-to-workspace-up; }
          Mod+Shift+Right  { move-column-right; }
          Mod+Shift+period { move-column-to-monitor-right; }
          Mod+Shift+comma  { move-column-to-monitor-left; }
          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+Shift+1 { move-window-to-workspace 1; }
          Mod+Shift+2 { move-window-to-workspace 2; }
          Mod+Shift+3 { move-window-to-workspace 3; }
          Mod+Shift+4 { move-window-to-workspace 4; }
          XF86AudioMute        { spawn "sh" "-c" "pactl set-sink-mute @DEFAULT_SINK@ toggle"; }
          XF86AudioLowerVolume { spawn "sh" "-c" "pactl set-sink-volume @DEFAULT_SINK@ -2%"; }
          XF86AudioRaiseVolume { spawn "sh" "-c" "pactl set-sink-volume @DEFAULT_SINK@ +2%"; }
          Mod+Shift+X { spawn "hyprlock"; }
          Mod+Shift+E { quit; }
      }
    '';

    programs.bash = {
      enable    = true;
      initExtra = ''
        set -o vi
        PS1='\[\e[38;2;224;137;161m\]\w \[\e[0m\]❯ '
      '';
      shellAliases = {
        ls  = "eza -l -a -h";
        ll  = "eza -l -a -h";
        vim = "hx";
      };
    };

    programs.eza = {
      enable                = true;
      enableBashIntegration = true;
    };

    programs.alacritty = {
      enable = true;
      settings = {
        font.normal = { family = "Iosevka"; style = "Regular"; };
        font.size   = 18;
        window.padding = { x = 10; y = 10; };
        colors.primary = {
          background = "#FDF6E3";
          foreground = "#000000";
        };
      };
    };

    programs.fuzzel = {
      enable = true;
      settings.colors.background = "FDF6E3ff";
      settings.colors.text       = "000000ff";
      settings.colors.border     = "458588ff";
      settings.main.font         = "Iosevka:size=18";
      settings.main.lines        = 12;
      settings.main.width        = 45;
      settings.main.terminal     = "alacritty";
    };

    programs.hyprlock = {
      enable = true;
      settings.background = [{ path = "screenshot"; blur_passes = 3; }];
      settings.input-field = [{
        outer_color = "rgb(458588)";
        inner_color = "rgb(FDF6E3)";
        font_color  = "rgb(000000)";
      }];
    };

programs.helix = {
  enable        = true;
  defaultEditor = true;
  settings.editor.line-number        = "relative";
  settings.editor.clipboard-provider = "wayland";
  extraPackages = [ pkgs.nixd ];
};


    home.file.".config/yazi/theme.toml".text = ''
      [mgr]
      hovered = { fg = "#FDF6E3", bg = "#458588" }
      [status]
      mode_normal = { fg = "#FDF6E3", bg = "#458588", bold = true }
    '';

    home.file.".config/yazi/yazi.toml".text = ''
      [mgr]
      show_hidden = true

      [opener]
      edit     = [{ run = 'alacritty -e hx "$@"', orphan = true }]
      image    = [{ run = 'imv "$@"', orphan = true, for = "unix" }]
      video    = [{ run = 'mpv "$@"', orphan = true, for = "unix" }]
      audio    = [{ run = 'mpv --force-window --no-resume-playback "$@"', orphan = true }]
      pdf      = [{ run = 'zathura "$@"', orphan = true, for = "unix" }]
      browser  = [{ run = 'firefox "$@"', orphan = true, for = "unix" }]

      [open]
      rules = [
        { mime = "image/*",         use = "image" },
        { mime = "video/*",         use = "video" },
        { mime = "audio/*",         use = "audio" },
        { mime = "text/*",          use = "edit" },
        { mime = "application/pdf", use = "pdf" },
        { mime = "text/html",       use = "browser" },
        { mime = "application/xhtml+xml", use = "browser" },
       ]
    '';
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree          = true;
  system.stateVersion = "26.05";
}
