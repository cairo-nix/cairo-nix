{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    cairo-nix = {
      url = "github:cairo-nix/cairo-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, cairo-nix, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import cairo-nix)
          ];
        };
      in
      {
        devShells = rec {
          default = stable;
          stable = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              cairo-bin.stable.cairo
              cairo-bin.stable.scarb
            ];
          };

          beta = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              cairo-bin.stable.cairo
              cairo-bin.stable.scarb
            ];
          };
        };
      });
}
