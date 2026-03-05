# nixos-config

My personal NixOS configuration — River WM on a single declarative system.

Live at [shaon.neocities.org](https://shaon.neocities.org)

---

## System

| | |
|---|---|
| **OS** | NixOS 25.11 |
| **WM** | River (Wayland) |
| **Terminal** | Ghostty + Alacritty |
| **Shell** | Bash + Starship |
| **Editor** | Neovim |
| **Browser** | Chromium |
| **Launcher** | Fuzzel |
| **Bar** | Waybar |
| **Notifications** | Mako |
| **Hardware** | Intel i5-6500 · 8GB RAM · 119GB NVMe |

---

## Structure
```
nixos-config/
├── configuration.nix       ← entire system declaration
└── hardware-configuration.nix  ← machine-specific hardware
```

---

## Apply
```bash
sudo nixos-rebuild switch
```

---

## Design Principles

- Everything declared. Nothing manual.
- Reproducible from scratch with one rebuild.
- Minimal — nothing installed without a reason.
- No home-manager yet. Keeping it simple.

---

## License

MIT — use freely.

---

## Author

**Shaon Ahmed Ronok**

[shaon.neocities.org](https://shaon.neocities.org) · [github.com/shaonahmedronok1](https://github.com/shaonahmedronok1)
