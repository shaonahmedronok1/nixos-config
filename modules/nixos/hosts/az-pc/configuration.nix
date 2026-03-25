{ config, pkgs, lib, ... }:
{
  imports = [
    ../../features/nix.nix
    ../../features/pipewire.nix
    ../../features/gtk.nix
    ../../features/hyprland.nix
    ../../features/general.nix
  ];

  # ── Boot ───────────────────────────────────────────────────────────────
  boot.loader.systemd-boot.enable      = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages                  = pkgs.linuxPackages_latest;
  boot.kernelModules                   = [ "i2c-dev" ];

  # ── Networking ─────────────────────────────────────────────────────────
  networking.hostName            = "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable     = true;

  # ── Locale ─────────────────────────────────────────────────────────────
  time.timeZone      = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT    = "en_US.UTF-8";
    LC_MONETARY       = "en_US.UTF-8";
    LC_NAME           = "en_US.UTF-8";
    LC_NUMERIC        = "en_US.UTF-8";
    LC_PAPER          = "en_US.UTF-8";
    LC_TELEPHONE      = "en_US.UTF-8";
    LC_TIME           = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout  = "us";
    variant = "";
  };

  # ── User ───────────────────────────────────────────────────────────────
  users.users.az = {
    isNormalUser = true;
    description  = "az";
    extraGroups  = [ "networkmanager" "wheel" "video" "input" "storage" "i2c" ];
    packages     = [];
  };

  security.pam.services.hyprlock = {};

  # ── Hardware ───────────────────────────────────────────────────────────
  hardware.graphics.enable             = true;
  hardware.cpu.intel.updateMicrocode   = true;
  hardware.i2c.enable                  = true;

  security.polkit.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      user    = "az";
      command = "Hyprland";
    };
  };

  # ── Fonts ──────────────────────────────────────────────────────────────
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    atkinson-hyperlegible
    font-awesome
  ];

  # ── Stylix ─────────────────────────────────────────────────────────────
  stylix = {
    enable = true;
    base16Scheme = {
      base00 = "242424";
      base01 = "3c3836";
      base02 = "504945";
      base03 = "665c54";
      base04 = "bdae93";
      base05 = "d5c4a1";
      base06 = "ebdbb2";
      base07 = "fbf1c7";
      base08 = "fb4934";
      base09 = "fe8019";
      base0A = "fabd2f";
      base0B = "b8bb26";
      base0C = "8ec07c";
      base0D = "7daea3";
      base0E = "e089a1";
      base0F = "f28534";
    };
    image = ../../../../wallpaper.jpg;
    fonts.monospace = {
      name    = "JetBrainsMono Nerd Font Mono";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    fonts.sansSerif = {
      name    = "Noto Sans";
      package = pkgs.noto-fonts;
    };
    fonts.serif = {
      name    = "Noto Serif";
      package = pkgs.noto-fonts;
    };
    fonts.emoji = {
      name    = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = lib.mkForce "gtk2";
  };

  system.stateVersion = "25.11";
}
