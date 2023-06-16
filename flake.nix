{
  description = "Cairo toolchain in nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    let
      overlay = import ./overlay.nix;
    in
    {
      overlays = {
        default = overlay;
      };
    };
}
