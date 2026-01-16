# NeoVim Flake

This repository is a **derivative / customized fork** of  
https://github.com/Gerg-L/nvim-flake

It keeps the same core ideas and architecture, but adapts the workflow and
documentation to make customization clearer and more explicit.

It is built on top of **Gerg-L Minimal NeoVim Wrapper (mnw)**:
https://github.com/Gerg-L/mnw

---
## What this is

- Neovim is built as a **standalone flake application**
- Plugins are **installed by Nix** (via `npins`)
- Plugin loading & configuration is handled by **lz.nv**
- lz.nvim is used **only as a loader/orchestrator**, not a package manager

In short:

> **Nix installs plugins**  
> **lz.nv loads them**  
> **Lua configures them**

---
# Test it out
With flakes enabled
```console
nix run github:Gerg-L/nvim-flake
```
Legacy (may seem like it stalls)
```console
nix-shell -p '(import (builtins.fetchTarball "https://github.com/Gerg-L/nvim-flake/archive/master.tar.gz")).packages.${builtins.currentSystem}.default' --run nvim
```
# To install

I'd recommend [forking](#forking-usage-guide) and modifiying to your use-case rather than using this as-is in your own config...

But if you want do use it anyways or install your fork here's how


## Flakes
Add this flake as an input
```nix
#flake.nix
{
  inputs = {
    nvim-flake = {
      url = "github:Gerg-L/nvim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
...
```
(Make sure you're passing inputs to your [modules](https://blog.nobbz.dev/posts/2022-12-12-getting-inputs-to-modules-in-a-flake))
### Add to user environment
```nix
#anyModule.nix
# add system wide
  environment.systemPackages = [
    inputs.nvim-flake.packages.${pkgs.stdenv.system}.neovim
  ];
# add per-user
  users.users."<name>".packages = [
    inputs.nvim-flake.packages.${pkgs.stdenv.system}.neovim
  ];
```

## Legacy
Use fetchTarball
```nix
let
  nvim-flake = import (builtins.fetchTarball {
  # Get the revision by choosing a version from https://github.com/Gerg-L/nvim-flake/commits/master
  url = "https://github.com/Gerg-L/nvim-flake/archive/<revision>.tar.gz";
  # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
  sha256 = "<hash>";
});
in
{
# add system wide
  environment.systemPackages = [
    nvim-flake.packages.${pkgs.stdenv.system}.neovim
  ];
# add per-user
  users.users."<name>".packages = [
    nvim-flake.packages.${pkgs.stdenv.system}.neovim
  ];
```

# Forking usage guide
Update the flake like any other `nix flake update`

Plugin management (THIS IS THE IMPORTANT PART)
Plugins are managed using npins, but not directly.
This repo provides two helper commands in the dev shell:

start → plugins loaded at startup
opt → optional / lazy plugins

Enter the dev shell
```bash
nix develop
```
Adding plugins
```sh
start add github owner repo
#or
opt add github owner repo
```
Examples:
```sh
start add github stevearc oil.nvim
opt add github nvim-neo-tree neo-tree.nvim
```
This will:

Update start.json / opt.json
Regenerate npins.nix
Make the plugin available to Neovim
[Warn] Do not use npins init or bare npins add in this repo.

Updating plugins
```sh
start update
opt update
```
---
##Plugin Workflow (How This Repo Works)

This Neovim configuration uses a hybrid Nix + lazy-style loader model.
Nix / npins installs and pins plugin sources (reproducibly)
lazy-style specs (lz.n) control when and how plugins are configured
Plugins are never downloaded at runtime
Use start or opt from the dev shell:
```sh
nix develop
```
Startup plugins (must exist immediately):
```sh
start add github owner repo [--branch main|master]
```
Optional / lazy plugins:
```sh
opt add github owner repo [--branch main|master]
```

This updates: start.json or opt.json
regenerates npins.nix
If a plugin has no GitHub releases, always pass --branch.

Decide: start vs opt (Important Rule)

Put a plugin in start if:
it is require()d during another plugin’s after hook
it must exist on runtimepath at startup

Put a plugin in opt if:
it can load later (commands, events, keys)
nothing eagerly depends on it
dependencies = {} controls load order,
start / opt controls runtime availability.

Configure the Plugin (lazy-style spec)
Create one file per plugin:

lua/lazy/<plugin>.lua

Example:
```nix
return {
  "plugin-name.nvim",
  lazy = false, -- or true

  dependencies = {
    "dependency.nvim",
  },

  after = function()
    require("plugin-name").setup({
      -- plugin config
    })
  end,

  wk = {
    { "<leader>x", "<CMD>Command<CR>", desc = "Description" },
  },
}
```
Notes:
The string "plugin-name.nvim" must match the pinned plugin directory
wk entries are picked up automatically by the which-key handler
One file = one plugin spec (never list multiple plugins in one spec)
Run
```sh
nix run .
```

If something fails, the layer tells you where to look:

Error type	Fix
Nix eval error	pinning / JSON
module not found	plugin in opt but required at startup
loader/spec error	malformed lua/lazy/*.lua
plugin runtime error	Lua config
Each plugin is configured via a lz.nv spec file:
Notes:
Plugins are already installed by Nix
The string "oil.nvim" is used as a lookup key, not a source
wk entries are automatically registered with which-key
## Inspiration
- [@the-argus's](https://github.com/the-argus) [nvim-config](https://github.com/the-argus/nvim-config)
- [@NotAShelf's](https://github.com/NotAShelf) [neovim-flake](https://github.com/NotAShelf/nvf)
- [@wiltaylor's](https://github.com/wiltaylor) [neovim-flake](https://github.com/wiltaylor/neovim-flake)
- [@jordanisaacs's](https://github.com/jordanisaacs) [neovim-flake](https://github.com/jordanisaacs/neovim-flake)
- [@gvolpe's](https://github.com/gvolpe) [neovim-flake](https://github.com/gvolpe/neovim-flake)

