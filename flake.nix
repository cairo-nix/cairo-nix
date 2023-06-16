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

      templates = {
        default = {
          path = ./templates/simple;
          description = "A basic project using cairo-nix";
        };
      };
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      {
        formatter = pkgs.nixpkgs-fmt;

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            cairo-bin.stable.latest.cairo
            cairo-bin.stable.latest.scarb
          ];
        };

        packages = {
          default = pkgs.cairo-bin.stable.latest.scarb;
          cairo = pkgs.cairo-bin.stable.latest.cairo;
          scarb = pkgs.cairo-bin.stable.latest.scarb;
        };
      });
}
