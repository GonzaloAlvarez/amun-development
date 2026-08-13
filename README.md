# amun-development

Amun plugin that turns a machine into a development box: [asdf](https://asdf-vm.com)
with pinned toolchains (nodejs+npm, python, java Temurin, golang, rust), the
[Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI, the
[OpenAI Codex](https://github.com/openai/codex) CLI, and a modern CLI kit
(fzf, ripgrep, fd, bat, jq, htop, tmux, direnv, gh, lazygit, git-delta).

Supported platforms: Debian/Ubuntu, macOS, Arch Linux.

## Usage

```sh
bash <(curl -fsSL https://go.gn.al/amun) development
```

or, if amun is already installed:

```sh
amun development
```

## What it does

| Role | Installs |
|---|---|
| `asdf` | asdf Go binary (GitHub release, sha256-verified; brew on macOS), per-OS build deps, five plugins + pinned versions, `~/.tool-versions`, `/etc/profile.d/asdf.sh` (Linux) |
| `claude` | Claude Code via the official installer into `~/.local/bin/claude` |
| `codex` | Codex CLI from GitHub release binaries (sha256-verified) into `/usr/local/bin/codex` |
| `devtools` | fzf, ripgrep, fd, bat, jq, htop, tmux, direnv, gh (apt repo on Debian), lazygit + git-delta (GitHub releases on Debian) |

## Variables (override with `-e`)

| Variable | Default | Notes |
|---|---|---|
| `asdf_version` | `0.20.0` | asdf release |
| `asdf_tools` | nodejs 24.19.0, python 3.14.7, java temurin-25.0.4+7.0.LTS, golang 1.26.6, rust 1.97.1 | list of `{name, plugin_repo, version}` |
| `claude_version` | `stable` | `stable`/`latest` = install once, don't chase; pin `X.Y.Z` to force a version |
| `codex_version` | `0.147.0` | GitHub release `rust-v<version>` |
| `devtools_lazygit_version` | `0.64.1` | used on Debian only |
| `devtools_delta_version` | `0.19.2` | used on Debian only (git-delta not in Debian stable) |

Notes:
- `~/.tool-versions` is owned by the template — manual `asdf set -u` additions
  are reverted on re-run; override `asdf_tools` instead.
- The direnv shell hook (`eval "$(direnv hook zsh)"`) is dotfiles territory;
  only the package is installed here.
- python compiles from source (python-build): expect 5–15 min on x86/arm64,
  30–60 min on a Pi.

## Verification (§14.1)

- **L1** — `./molecule test` (Docker, Debian 12, converges all four roles,
  idempotence + assert suite). Arch has no L1 image; covered by L2.
- **L2** — `~/dev/amun/test debian -p development` / `arch` / `mac`
  (parent harness; boots a tart/QEMU VM, runs amun base + this plugin from
  the local working tree).
- **L3** — `ssh rpid11.lan amun development` (only sanctioned real host).
- **L4** — `./verify [--host HOST]` — pure-shell PASS/FAIL spot check.
