# Cairo Nix Overlay

This repo contains a Nix overlay that provides a ready-to-use Cairo development
environment.

## Usage

### Quick use

Use `nix shell` to quickly create a shell with all the
development tools needed for Cairo.

```
$ nix shell github:cairo-nix/cairo-nix
$ cairo-compile --version
cairo-lang-compiler 1.1.0
$ scarb --version
scarb 0.4.0
cairo: 1.1.0 (43b83560d)
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

