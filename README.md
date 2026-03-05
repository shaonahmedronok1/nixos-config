<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:ffb7c5,100:c2185b&height=180&section=header&text=nixos-config&fontSize=36&fontColor=fff&fontAlignY=38&desc=Declarative%20NixOS%20%C2%B7%20River%20WM%20%C2%B7%20Wayland&descAlignY=58&descColor=ffe0ec"/>

[![Website](https://img.shields.io/badge/🌸%20shaon.neocities.org-c2185b?style=for-the-badge)](https://shaon.neocities.org)
[![NixOS](https://img.shields.io/badge/NixOS-25.11-%235277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![River](https://img.shields.io/badge/River-WM-c2185b?style=for-the-badge&logo=wayland&logoColor=white)](https://isaacfreund.com/software/river/)

*Everything declared. Nothing manual. Reproducible from scratch with one rebuild.*

</div>

---

<div align="center">

## 🌸 System

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

## 🌺 Structure
```
nixos-config/
├── configuration.nix          ← entire system declaration
└── hardware-configuration.nix ← machine-specific hardware
```

---

## 🌸 Apply
```bash
sudo nixos-rebuild switch
```

---

## 🌺 Design Principles

- Everything declared. Nothing manual.
- Reproducible from scratch with one rebuild.
- Minimal — nothing installed without a reason.
- No home-manager yet. Keeping it simple.

---

## License

MIT — use freely.

---

*"The burden of proof lies with the addition."*

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:c2185b,100:ffb7c5&height=120&section=footer"/>

</div>
