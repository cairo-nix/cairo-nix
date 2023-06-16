# Cairo Nix Overlay

This repo contains a Nix overlay that provides a ready-to-use Cairo development
environment.

## Usage

![cairo-nix in use](https://github.com/cairo-nix/cairo-nix/assets/282580/ba3b48d8-23c7-46b6-b926-977d6adb274a)

### Quick use

**NOTICE**: on first use, nix will download and build cairo and scarb. This can
take a while, but it's a one time only operation. In the future, we will publish
a binary cache to speed up first use.

Use `nix shell` to easily create a shell with all the
development tools needed.

By default, it creates a shell with scarb installed.

```sh
nix shell github:cairo-nix/cairo-nix
scarb --version
```
```txt
scarb 0.5.2
cairo: 2.0.2 (https://crates.io/crates/cairo-lang-compiler/2.0.2)
```

### From template

You can use `nix flake new` to create a new project that's already configured
to use this overlay.

```sh
nix flake new --template github:cairo-nix/cairo-nix
```

The template includes two development shells, one with the stable Cairo release
(default), one with the beta release. You can easily switch between these two
environments using `nix develop`.

```sh
# use default (stable) Cairo
nix develop
# alternatively
nix develop .#stable
```

```sh
# use next Cairo version
nix develop .#beta
```

## Roadmap

This overlay is in _very_ early stage and it's subject
to change.
As long as you don't run `nix flake update` to update
to a more recent version, you'll be fine.

 - [x] Build stable Cairo binaries.
 - [x] Build beta/nightly binaries.
 - [x] Add `scarb` component.
 - [ ] Add `vscode-extension` component.
 - [ ] Add binary cache for faster build times.
 - [x] Add template project.

