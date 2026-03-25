{ config, pkgs, lib, ... }:
{
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
      truecolor        = true;
      force_tty        = false;
      shown_boxes      = "cpu net proc";
      update_ms        = 2000;
      presets          = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
      vim_keys         = true;
      rounded_corners  = true;
      graph_symbol     = "braille";
      proc_sorting     = "cpu lazy";
      proc_colors      = true;
      proc_gradient    = true;
      proc_mem_bytes   = true;
      proc_cpu_graphs  = true;
      base_10_sizes    = true;
    };
  };

  programs.mpv = {
    enable = true;
    config = {
      profile        = "fast";
      vo             = "gpu";
      hwdec          = "vaapi";
      "gpu-api"      = "opengl";
      save-position-on-quit = true;
      osc            = false;
      border         = false;
      cursor-autohide = 1000;
      slang          = "en,eng,enUS,enGB,enAU,enNZ,enCA,enIE,enZA";
      ytdl-raw-options = "ignore-config=,sub-langs=\"en.*,^en\",write-subs=,write-auto-subs=";
      sub-visibility = "yes";
      sub-auto       = "fuzzy";
      sub-font       = "JetBrainsMono Nerd Font Mono";
      sub-font-size  = 33;
      sub-border-size = 3;
      sub-shadow-offset = 1;
      sub-pos        = 98;
      sub-align-y    = "bottom";
      sub-margin-y   = 20;
      osd-font       = "JetBrainsMono Nerd Font";
      osd-font-size  = 28;
    };
    bindings = {
      "l"     = "seek 5";
      "h"     = "seek -5";
      "k"     = "add volume 2";
      "j"     = "add volume -2";
      "f"     = "cycle fullscreen";
      "SPACE" = "cycle pause";
      "s"     = "screenshot";
      "S"     = "cycle sub";
      "v"     = "cycle sub-visibility";
      "]"     = "add speed 0.1";
      "["     = "add speed -0.1";
      "BS"    = "set speed 1.0";
      "q"     = "quit";
      "Q"     = "quit-watch-later";
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width  = 10;
      background_opacity    = "1.0";
      cursor_shape          = "block";
      font_family           = "JetBrainsMono Nerd Font";
      font_size             = 16;
      cursor_trail          = 3;
      background            = "#242424";
      foreground            = "#ebdbb2";
      cursor                = "#ebdbb2";
      cursor_text_color     = "#242424";
      selection_background  = "#504945";
      selection_foreground  = "#d5c4a1";
      active_tab_background   = "#242424";
      active_tab_foreground   = "#ebdbb2";
      inactive_tab_background = "#3c3836";
      inactive_tab_foreground = "#665c54";
      color0  = "#242424"; color8  = "#504945";
      color1  = "#fb4934"; color9  = "#fb4934";
      color2  = "#b8bb26"; color10 = "#b8bb26";
      color3  = "#fabd2f"; color11 = "#fabd2f";
      color4  = "#7daea3"; color12 = "#7daea3";
      color5  = "#e089a1"; color13 = "#e089a1";
      color6  = "#8ec07c"; color14 = "#8ec07c";
      color7  = "#ebdbb2"; color15 = "#fbf1c7";
    };
  };

  services.mako = {
    enable = true;
    settings = {
      border-size      = 2;
      border-radius    = 6;
      font             = lib.mkForce "JetBrainsMono Nerd Font 13";
      width            = 400;
      height           = 120;
      padding          = "12";
      margin           = "10";
      default-timeout  = 11000;
      ignore-timeout   = 0;
    };
  };

  
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font     = lib.mkForce "JetBrainsMono Nerd Font:size=16";
        lines    = 12;
        width    = 45;
        terminal = "kitty";
      };
      colors = {
        background    = "242424ff";
        text          = "ebdbb2ff";
        match         = "b8bb26ff";
        selection     = "3c3836ff";
        selection-text  = "ebdbb2ff";
        selection-match = "fabd2fff";
        border        = "7daea3ff";
      };
      border = {
        width  = 2;
        radius = 6;
      };
    };
  };


  programs.imv = {
    enable = true;
    settings = {
      options = {
        background               = "242424";
        overlay_text_color       = "ebdbb2";
        overlay_background_color = "3c3836";
        overlay_font             = "JetBrainsMono Nerd Font:12";
      };
      binds = {
        "<Ctrl+p>"       = ''exec lp "$imv_current_file"'';
        "<Ctrl+x>"       = ''exec rm "$imv_current_file"; quit'';
        "<Ctrl+Shift+X>" = ''exec rm "$imv_current_file"; close'';
        "<Ctrl+r>"       = ''exec mogrify -rotate 90 "$imv_current_file"'';
      };
    };
  };

  # ── Config files ────────────────────────────────────────────────────────

  home.file.".config/fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "type": "kitty-direct",
        "source": "/home/az/dirrr/ff1.png",
        "width": 32,
        "height": 15,
        "padding": { "top": 1, "left": 1, "right": 4 }
      },
      "display": { "separator": " : " },
      "modules": [
        "break",
        { "type": "custom", "format": "\u001b[90m┌──────────────────────Hardware──────────────────────┐" },
        { "type": "host",    "key": " PC",  "keyColor": "green" },
        { "type": "cpu",     "key": "│ ├",  "showPeCoreCount": true, "keyColor": "green" },
        { "type": "gpu",     "key": "│ ├",  "detectionMethod": "pci", "keyColor": "green" },
        { "type": "display", "key": "│ ├󱄄", "keyColor": "green" },
        { "type": "disk",    "key": "│ ├󰋊", "keyColor": "green" },
        { "type": "memory",  "key": "│ ├",  "keyColor": "green" },
        { "type": "swap",    "key": "└ └󰓡 ", "keyColor": "green" },
        { "type": "custom", "format": "\u001b[90m└────────────────────────────────────────────────────┘" },
        "break",
        { "type": "custom", "format": "\u001b[90m┌──────────────────────Software──────────────────────┐" },
        { "type": "command", "key": "\ue900 OS",  "keyColor": "blue", "text": "version=$(nixos-version); echo \"nixos $version\"" },
        { "type": "command", "key": "│ ├󰘬",       "keyColor": "blue", "text": "branch=$(nixos-version-branch); echo \"$branch\"" },
        { "type": "command", "key": "│ ├󰔫",       "keyColor": "blue", "text": "channel=$(nixos-version-channel); echo \"$channel\"" },
        { "type": "kernel",  "key": "│ ├",        "keyColor": "blue" },
        { "type": "wm",      "key": "│ ├",        "keyColor": "blue" },
        { "type": "de",      "key": " DE",        "keyColor": "blue" },
        { "type": "terminal","key": "│ ├",        "keyColor": "blue" },
        { "type": "packages","key": "│ ├󰏖",       "keyColor": "blue" },
        { "type": "wmtheme", "key": "│ ├󰉼",       "keyColor": "blue" },
        { "type": "command", "key": "│ ├󰸌",       "keyColor": "blue", "text": "theme=$(nixos-theme-current); echo -e \"$theme \\e[38m●\\e[37m●\\e[36m●\\e[35m●\\e[34m●\\e[33m●\\e[32m●\\e[31m●\"" },
        { "type": "terminalfont", "key": "└ └",   "keyColor": "blue" },
        { "type": "custom", "format": "\u001b[90m└────────────────────────────────────────────────────┘" },
        "break",
        { "type": "custom", "format": "\u001b[90m┌────────────────Age / Uptime / Update───────────────┐" },
        { "type": "command", "key": "󱦟 OS Age", "keyColor": "magenta", "text": "echo $(( ($(date +%s) - $(stat -c %W /)) / 86400 )) days" },
        { "type": "uptime",  "key": "󱫐 Uptime", "keyColor": "magenta" },
        { "type": "command", "key": " Update",  "keyColor": "magenta", "text": "updated=$(nixos-version-pkgs); echo \"$updated\"" },
        { "type": "custom", "format": "\u001b[90m└────────────────────────────────────────────────────┘" },
        "break"
      ]
    }
  '';

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

  home.file.".config/yazi/yazi.toml".text = ''
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
        { mime = "audio/*",           use = "play_audio" },
        { mime = "image/*",           use = "image" },
        { mime = "text/*",            use = "edit" },
        { mime = "video/*",           use = [ "open" ] },
        { mime = "application/pdf",   use = "open_pdf" },
    ]
    [[open.prepend_rules]]
    mime = "text/html"
    use = "browser"
    [[open.prepend_rules]]
    mime = "application/xhtml+xml"
    use = "browser"
  '';

  home.file.".config/yazi/theme.toml".text = ''
    [mgr]
    cwd             = { fg = "#b8bb26", bold = true }
    hovered         = { fg = "#242424", bg = "#b8bb26" }
    find_keyword    = { fg = "#b8bb26", bold = true }
    find_position   = { fg = "#fe8019", bg = "reset", bold = true }
    marker_copied   = { fg = "#b8bb26", bg = "#b8bb26" }
    marker_cut      = { fg = "#fb4934", bg = "#fb4934" }
    marker_selected = { fg = "#7daea3", bg = "#7daea3" }
    count_copied    = { fg = "#242424", bg = "#b8bb26" }
    count_cut       = { fg = "#242424", bg = "#fb4934" }
    count_selected  = { fg = "#242424", bg = "#7daea3" }
    border_symbol   = "│"
    border_style    = { fg = "#665c54" }

    [indicator]
    preview = { underline = true }

    [tabs]
    active   = { fg = "#242424", bg = "#b8bb26", bold = true }
    inactive = { fg = "#bdae93", bg = "#3c3836" }

    [status]
    separator_open  = ""
    separator_close = ""
    separator_style = { fg = "#3c3836", bg = "#3c3836" }
    mode_normal     = { fg = "#242424", bg = "#b8bb26", bold = true }
    mode_select     = { fg = "#242424", bg = "#b8bb26", bold = true }
    mode_unset      = { fg = "#242424", bg = "#7daea3", bold = true }
    progress_label  = { fg = "#ebdbb2", bold = true }
    progress_normal = { fg = "#7daea3", bg = "#3c3836" }
    progress_error  = { fg = "#fb4934", bg = "#3c3836" }
    permissions_t   = { fg = "#fe8019" }
    permissions_r   = { fg = "#b8bb26" }
    permissions_w   = { fg = "#fb4934" }
    permissions_x   = { fg = "#7daea3" }
    permissions_s   = { fg = "#665c54" }

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
      { mime = "image/*",         fg = "#7daea3" },
      { mime = "video/*",         fg = "#fe8019" },
      { mime = "audio/*",         fg = "#b8bb26" },
      { mime = "text/*",          fg = "#ebdbb2" },
      { mime = "inode/directory", fg = "#fe8019", bold = true },
      { name = "*.nix",           fg = "#7daea3" },
      { name = "*.rs",            fg = "#fe8019" },
      { name = "*.py",            fg = "#fabd2f" },
      { name = "*.sh",            fg = "#b8bb26" },
      { name = "*.md",            fg = "#ebdbb2" },
      { name = "*.toml",          fg = "#fe8019" },
      { name = "*.json",          fg = "#fabd2f" },
    ]
  '';

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
        opts = { colorscheme = "gruvbox" },
      },
    }
  '';

  home.file.".config/nvim/lua/plugins/lsp.lua".text = ''
    return {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "pyright", "ruff-lsp", "html-lsp", "css-lsp",
            "typescript-language-server", "prettier", "eslint-lsp",
          },
        },
      },
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            pyright  = {},
            ruff_lsp = {},
            html     = {},
            cssls    = {},
            tsserver = {},
          },
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
}
