# Cairo Nix Overlay

This repo contains a Nix overlay that provides a ready-to-use Cairo development
environment.

## Usage

### Quick use

Use `nix shell` to quickly create a shell with all the
development tools needed.

By default, it creates a shell with scarb installed.

```
$ nix shell github:cairo-nix/cairo-nix
$ scarb --version
scarb 0.4.0
cairo: 1.1.0 (43b83560d)
```

You can optionally decide to create a shell with the cairo tools installed.

```
$ nix shell github:cairo-nix/cairo-nix
$ cairo-compile --version
cairo-lang-compiler 1.1.0
```

If you need both sets of components installed, you can add the overlay to your
project's `flake.nix` and customize the installed packages.

### From template

You can use `nix flake new` to create a new project that's already configured
to use this overlay.

```
nix flake new --template github:cairo-nix/cairo-nix
```

## Roadmap

This overlay is in _very_ early stage and it's subject
to change.
As long as you don't run `nix flake update` to update
to a more recent version, you'll be fine.

 - [x] Build stable Cairo binaries.
 - [ ] Build beta/nightly binaries.
 - [x] Add `scarb` component.
 - [ ] Add `vscode-extension` component.
 - [ ] Add binary cache for faster build times.
 - [ ] Add template project.

