{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    cairo-nix.url = "github:cairo-nix/cairo-nix";
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
        # start devshell with `nix develop .#<shell-name>`.
        devShells = rec {
          # default shell if no shell specified.
          default = stable;

          # stable cairo and scarb releases.
          stable = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              cairo-bin.stable.cairo
              cairo-bin.stable.scarb
            ];
          };

          # beta cairo and scarb releases.
          beta = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              cairo-bin.stable.cairo
              cairo-bin.stable.scarb
            ];
          };
        };
      });
}
