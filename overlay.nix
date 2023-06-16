final: prev:
{
  cairo-bin.stable.latest = rec {
    cairo = final.rustPlatform.buildRustPackage rec {
      pname = "cairo";
      version = "1.1.0";

      doCheck = false;

      src = final.fetchFromGitHub {
        owner = "starkware-libs";
        repo = pname;
        rev = "v${version}";
        hash = "sha256-8dzDe4Kw9OASD0i3bMooqEclStxS/Ta/tOVCcFhvwSI=";
      };

      cargoHash = "sha256-IY3RE+EeNRhUSZX+bqojhPl6y8qm+i9C0zQmNApmat8=";

      meta = with final.lib; {
        description = " Cairo is the first Turing-complete language for creating provable programs for general computation.";
        homepage = "https://github.com/starkware-libs/cairo";
        license = licenses.asl20;
        maintainers = [ ];
      };
    };

    cairo-archive =
      let
        fetch_cairo = { rev, hash }: final.fetchurl {
          name = "cairo-archive-${rev}";
          url = "https://github.com/starkware-libs/cairo/archive/${rev}.zip";
          sha256 = hash;
          meta = {
            version = rev;
          };
        };
      in
      fetch_cairo {
        rev = "43b83560d9be2ebbb1c18e9db86ecd05ae7495ba";
        hash = "sha256-rlD70Wq34jiZoWM9uJlsJZilH8FjDiuuZF5zPQ+PALQ=";
      };

    scarb = final.rustPlatform.buildRustPackage rec {
      pname = "scarb";
      version = "0.4.0";

      doCheck = false;

      src = final.fetchFromGitHub {
        # owner = "software-mansion";
        owner = "fracek";
        repo = pname;
        # fix nix build, backported to 0.4.0
        rev = "dfffd30d4ae5b727676d7f371d7b7d7fc54e0e70";
        hash = "sha256-H3ZaBxjZWCyThLJ5Nw4KnQ4+SMld+Lwc9oCmY971hNI=";
      };

      cargoLock = {
        lockFile = ./Cargo.lock;
        outputHashes = {
          "cairo-lang-casm-1.1.0" = "sha256-Mp+P+SNZW1hlKgqo+zCopVa5PaTQX/3giDz9ynsj6L0=";
        };
      };

      CAIRO_ARCHIVE = cairo-archive;

      meta = with final.lib; {
        description = "The Cairo package manager";
        homepage = "http://docs.swmansion.com/scarb/";
        license = licenses.asl20;
        maintainers = [ ];
      };
    };
  };
}
