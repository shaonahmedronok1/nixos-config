# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

imports =
  [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.az = {
    isNormalUser = true;
    description = "az";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "storage" "i2c" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim
     wget
     river-classic
     chromium
     foot
     alacritty
     nautilus
     ddcutil
     neovim
     udisks2
     udiskie
     btop
     fastfetch
     wl-clipboard
     xdg-terminal-exec
     ghostty
     waybar
     wiremix
     wlsunset
     cliphist
     wtype
     wl-clip-persist
     wl-clipboard
     wlr-randr
     swayidle
     swaylock
     swaybg
     kdePackages.dolphin
  swaylock
  mako
  slurp
  grim
  wl-clipboard
  xdg-terminal-exec
  xdg-desktop-portal-gtk
  xdg-desktop-portal-wlr
  starship
  atuin
  zoxide
  tmux
  yazi
  ncdu
  dust
  fd
  ripgrep
  fzf
  eza
  bat
  tree
  jq
  yq
  less
  gvfs
  obsidian
  firefox
  git
  github-cli
  lazygit
  brightnessctl
  playerctl
  pamixer
  wireplumber
  plocate
  curl
  unzip
  p7zip
  man-db
  tldr
  networkmanagerapplet
  clang
  rustup
  python3
  luarocks
  typst
  mpv
  imv
  imagemagick
  yt-dlp
  obs-studio
  shotcut
  kdePackages.kdenlive
  libreoffice-fresh
  evince
  xournalpp
  inkscape
  pinta
  flameshot
  signal-desktop
  localsend
  keepassxc
  gnome-calculator
  gnome-disk-utility
  gnome-keyring
  libqalculate
  docker-compose
  lazydocker
  spotify
  xonotic
  gpu-screen-recorder
  fcitx5
  fcitx5-gtk
  qt5.qtwayland
  snapper
  gum
  hyprpicker
  polkit_gnome
  swww
  fuzzel
  tree-sitter
  iwd
  wev
     git
 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  
  boot.kernelModules = [ "i2c-dev" ];
  hardware.graphics.enable = true;
  hardware.cpu.intel.updateMicrocode = true;
  security.polkit.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.river-classic}/bin/river";
      user = "az";
    };
  };
  
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
};

nix.settings.experimental-features = [ "nix-command" "flakes" ];

hardware.i2c.enable = true;

services.gvfs.enable = true;
services.udisks2.enable = true;



hardware.bluetooth.enable = true;
services.blueman.enable = true;
services.printing.enable = true;
services.avahi.enable = true;
services.avahi.nssmdns4 = true;
services.power-profiles-daemon.enable = true;
zramSwap.enable = true;
security.rtkit.enable = true;
networking.firewall.enable = true;

xdg.portal = {
  enable = true;
  wlr.enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  config.common.default = "*";
};

fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-color-emoji
  nerd-fonts.jetbrains-mono
  atkinson-hyperlegible
  font-awesome
];

security.pam.services.swaylock = {};



  system.stateVersion = "25.11"; # Did you read the comment?

}
