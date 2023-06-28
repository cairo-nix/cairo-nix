final: prev:
let
  fetchCairo = { rev, hash }: final.fetchurl {
    name = "cairo-archive-${rev}";
    url = "https://github.com/starkware-libs/cairo/archive/v${rev}.zip";
    sha256 = hash;
    meta = {
      version = rev;
    };
  };

  mkCairo = { cairo, scarb }:
    let
    in
    {
      cairo = final.rustPlatform.buildRustPackage rec {
        pname = "cairo";
        version = cairo.version;

        doCheck = false;

        src = final.fetchFromGitHub {
          owner = "starkware-libs";
          repo = pname;
          rev = "v${cairo.version}";
          hash = cairo.srcHash;
        };

        cargoHash = cairo.cargoHash;

        meta = with final.lib; {
          description = " Cairo is the first Turing-complete language for creating provable programs for general computation.";
          homepage = "https://github.com/starkware-libs/cairo";
          license = licenses.asl20;
          maintainers = [ ];
        };
      };

      scarb = final.rustPlatform.buildRustPackage rec {
        pname = "scarb";
        version = scarb.version;

        doCheck = false;

        src = final.fetchFromGitHub {
          owner = scarb.repo;
          repo = pname;
          rev = "v${scarb.version}";
          hash = scarb.srcHash;
        };

        cargoLock = {
          lockFile = ./Cargo.lock;
          outputHashes = scarb.cargoOutputHashes;
        };

        CAIRO_ARCHIVE = fetchCairo {
          rev = cairo.version;
          hash = cairo.archiveHash;
        };

        meta = with final.lib; {
          description = "The Cairo package manager";
          homepage = "http://docs.swmansion.com/scarb/";
          license = licenses.asl20;
          maintainers = [ ];
        };
      };
    };
in
{
  cairo-bin.stable.latest = mkCairo {
    cairo = {
      version = "1.1.0";
      srcHash = "sha256-8dzDe4Kw9OASD0i3bMooqEclStxS/Ta/tOVCcFhvwSI=";
      archiveHash = "sha256-u3ONdg/B8PS82alK9l7aurVlwK0v8bXy95dbY9s2TT0=";
      cargoHash = "sha256-IY3RE+EeNRhUSZX+bqojhPl6y8qm+i9C0zQmNApmat8=";
    };
    scarb = {
      version = "0.4.0-patch";
      repo = "fracek";
      srcHash = "sha256-kpuBexEWZ1Jg+YIgbZ1bEQSd9ZXKsKK9U7sG4hYAXUI=";
      cargoOutputHashes = {
        "cairo-lang-casm-1.1.0" = "sha256-Mp+P+SNZW1hlKgqo+zCopVa5PaTQX/3giDz9ynsj6L0=";
      };
    };
  };
}
