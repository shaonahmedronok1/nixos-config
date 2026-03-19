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


security.pam.services.hyprlock = {};





  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     
#IDEs/Text=editors
     neovim
     vscodium.fhs

#Writings
     typst

#Terminal emulators
     kitty
     alacritty
          
#Browsers
     google-chrome
     librewolf
     firefox
     tor-browser

#Image viwer
     imv

#Media player
     mpv

#Img-Vid editros
     gimp
     inkscape

#Topbar
     waybar

#Application-launcher
     fuzzel

#Audio-stuff
     wiremix
     wireplumber
     pamixer
     sonic-pi

#Clipboard-stuff
     wl-clipboard
     cliphist
     wl-clip-persist
     xdg-terminal-exec
     wtype

#File-managers/drive-mounting-and-others
     yazi
     kdePackages.dolphin
     gvfs
     udisks2
     udiskie
     gnome-disk-utility
     unzip
     p7zip

#Password-manager
     keepassxc

#notification
     mako

#screenshort
     slurp
     grim
     flameshot

#Screen-recorders
     obs-studio
     gpu-screen-recorder

#night-light
     wlsunset

#Task-manager
     btop

#System-info
     fastfetch 

#Display-stuff
     ddcutil
     wlr-randr
     hypridle
     swaybg
     xdg-desktop-portal-gtk
     polkit_gnome
     qt5.qtwayland
     brightnessctl
     swww

#manual-pages
     man-db

#Calculator
     gnome-calculator

#Network-connectivity
     iwd
     networkmanagerapplet

 
#Utils
     wget
     nh
     lolcat
     bat
     figlet
     nautilus
     starship
     atuin
     zoxide
     ncdu
     dust
     fd
     ripgrep
     fzf
     eza
     tree
     jq
     yq
     less
     playerctl
     plocate
     curl
     tldr
     clang
     rustup
     python3
     luarocks
     imagemagick
     yt-dlp
     evince
     pinta
     localsend
     gnome-keyring
     libqalculate
     fcitx5
     fcitx5-gtk
     snapper
     gum
     hyprpicker
     tree-sitter
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
    user = "az";
    command = "Hyprland";
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
  extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
  ];
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


programs.hyprland = {
  enable = true;
  withUWSM = true;
  xwayland.enable = true;
};


services.flatpak.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?

}
