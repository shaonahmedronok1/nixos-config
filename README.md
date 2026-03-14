<div align="center">
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:ffb7c5,100:c2185b&height=180&section=header&text=nixos-config&fontSize=36&fontColor=fff&fontAlignY=38&desc=Declarative%20NixOS%20%C2%B7%20Flakes%20%C2%B7%20Home%20Manager%20%C2%B7%20Hyprland%20WM%20%C2%B7%20Wayland&descAlignY=58&descColor=ffe0ec"/>

[![Website](https://img.shields.io/badge/🌸%20shaon.neocities.org-c2185b?style=for-the-badge)](https://shaon.neocities.org)
[![NixOS](https://img.shields.io/badge/NixOS-25.11-%235277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/Hyprland-WM-58E1FF?style=for-the-badge&logo=wayland&logoColor=black)](https://hyprland.org/)
[![Flakes](https://img.shields.io/badge/Flakes-Enabled-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Home Manager](https://img.shields.io/badge/Home_Manager-25.11-c2185b?style=for-the-badge)](https://nix-community.github.io/home-manager/)

*Everything declared. Nothing manual. Reproducible from scratch with one rebuild.*

</div>

---

<div align="center">

## 🌸 System

| | |
|---|---|
| **OS** | NixOS 25.11 |
| **WM** | Hyprland (Wayland) |
| **Terminal** | Kitty + Ghostty + Alacritty |
| **Shell** | Bash + Starship |
| **Editor** | Neovim |
| **Launcher** | Fuzzel |
| **Bar** | Waybar |
| **Notifications** | Mako |
| **Clipboard** | cliphist + wl-clipboard |
| **Screen Lock** | Swaylock |
| **Idle Daemon** | Swayidle |
| **Warm Light** | Wlsunset |

---

## 🌺 Structure

```
nixos-config/
├── flake.nix                  ← entry point, versions pinned
├── flake.lock                 ← exact version snapshot, never touch
├── configuration.nix          ← system-level declaration
├── home.nix                   ← Home Manager user config, all dotfiles
└── hardware-configuration.nix ← machine-specific, regenerate fresh on new PC
```

---

## 🌸 Apply

**First time on a new machine:**
```bash
git clone https://github.com/shaonahmedronok1/nixos-config
sudo cp nixos-config/flake.nix /etc/nixos/
sudo cp nixos-config/flake.lock /etc/nixos/
sudo cp nixos-config/configuration.nix /etc/nixos/
sudo cp nixos-config/home.nix /etc/nixos/
# generate fresh hardware-configuration.nix — never copy this one
sudo nixos-generate-config
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

**Daily use — after editing any config:**
```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

**Monthly update:**
```bash
sudo nix flake update /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

---

## 🌺 Design Principles

- Everything declared. Nothing manual.
- Reproducible from scratch with one rebuild.
- Minimal — nothing installed without a reason.
- Flakes for version pinning — exact reproducibility guaranteed.
- Home Manager as NixOS module — all dotfiles declared in `home.nix`.
- `~/.config` is entirely symlinks to `/nix/store/` — never edited directly.
- `hardware-configuration.nix` is machine-specific — always regenerate fresh.
- `flake.lock` is committed — guarantees identical rebuild anywhere, anytime.

---

## License

MIT — use freely.

---

*"The burden of proof lies with the addition."*

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:c2185b,100:ffb7c5&height=120&section=footer"/>

</div>
