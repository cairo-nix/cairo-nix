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
          owner = "software-mansion";
          repo = pname;
          rev = "v${scarb.version}";
          hash = scarb.srcHash;
        };

        cargoHash = scarb.cargoHash;
        cargoLock = scarb.cargoLock;

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

  versions = [
    {
      cairo = {
        version = "1.1.0";
        srcHash = "sha256-8dzDe4Kw9OASD0i3bMooqEclStxS/Ta/tOVCcFhvwSI=";
        archiveHash = "sha256-u3ONdg/B8PS82alK9l7aurVlwK0v8bXy95dbY9s2TT0=";
        cargoHash = "sha256-IY3RE+EeNRhUSZX+bqojhPl6y8qm+i9C0zQmNApmat8=";
      };
      scarb = {
        version = "0.4.1";
        srcHash = "sha256-1PL0qesYvAe2CFAC75ABNOwIRlLT6rDgt3UBdWdB0X0=";
        cargoHash = null;
        cargoLock = {
          lockFile = ./lockfiles/v0.4.1/Cargo.lock;
          outputHashes = {
            "cairo-lang-casm-1.1.1" = "sha256-dC6BkwSMoIgh5+G/mNlnJIBrjenfCoLIQKJg6CSmtcE=";
          };
        };
      };
    }
    {
      cairo = {
        version = "2.0.0-rc5";
        srcHash = "sha256-8dzDe4Kw9OASD0i3bMooqEclStxS/Ta/tOVCcFhvwSI=";
        archiveHash = "sha256-0hvdNlJL6CO7QgL7qypcL1eved0xbRUWvEGydt7RY58=";
        cargoHash = "sha256-2Ga3hJY7o71jHnC/04l42l3htRH6Jh5p+C7EQeQcdtc=";
      };
      scarb = {
        version = "0.5.0-alpha.3";
        srcHash = "sha256-PLGcioehKFED2NguCKVWDHGWUjp6bxcd0bChn79UdZM=";
        cargoHash = "sha256-cnYlaQG8LbVRgUC4OcW+RfpB4CcixVq9TVDxD6gWlcY=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.0.0-rc6";
        srcHash = "sha256-rwep93Iz5TXxfpwKpWgZl+5TvrDF5Nc3lS5gcb/hOKE=";
        archiveHash = "sha256-NV8GfJHmvVjfaDwNOjVwClaAxy/UxlA6uIlTE9pU9x8=";
        cargoHash = "sha256-r9/FEICiU4crTSzk7OCWffFLIGwP90TsqQRd9k21MJQ=";
      };
      scarb = {
        version = "0.5.0-alpha.4";
        srcHash = "sha256-THgg2la89f0r1kAICiKWuinb3BoZb9s9pirHxZL9Jt0=";
        cargoHash = "sha256-86EtJWEFMmCOTslp73EmPdrP6kzIoLv5ZRU6mSqOeW0=";
        cargoLock = null;
      };
    }
  ];

  toolchains =
    builtins.listToAttrs (builtins.map (v: { name = v.cairo.version; value = mkCairo v; }) versions);
in
{
  cairo-bin = (toolchains // {
    stable = toolchains."1.1.0";
    beta = toolchains."2.0.0-rc6";
  });
}
