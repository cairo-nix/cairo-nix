final: prev:
{
  cairo-bin.stable.latest = final.rustPlatform.buildRustPackage rec {
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
}
