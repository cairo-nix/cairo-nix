final: prev:
let
  inherit (final)
    lib stdenv darwin fetchurl fetchFromGitHub rustPlatform;

  fetchCairo = { rev, hash }: fetchurl {
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
      cairo = rustPlatform.buildRustPackage rec {
        pname = "cairo";
        version = cairo.version;

        doCheck = false;

        src = fetchFromGitHub {
          owner = "starkware-libs";
          repo = pname;
          rev = "v${cairo.version}";
          hash = cairo.srcHash;
        };

        cargoHash = cairo.cargoHash;

        meta = with lib; {
          description = " Cairo is the first Turing-complete language for creating provable programs for general computation.";
          homepage = "https://github.com/starkware-libs/cairo";
          license = licenses.asl20;
          maintainers = [ ];
        };
      };

      scarb = rustPlatform.buildRustPackage rec {
        pname = "scarb";
        version = scarb.version;

        doCheck = false;

        buildInputs = lib.optional stdenv.isDarwin [
          darwin.apple_sdk.frameworks.CoreFoundation
        ];

        src = fetchFromGitHub {
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

        meta = with lib; {
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
    {
      cairo = {
        version = "2.0.0";
        srcHash = "sha256-39D1ZYAJpmlsENscj7puWcHspqRjoZh9bNVtjYcR0A0=";
        archiveHash = "sha256-Q1i8b/VpG2ujq/6FEzqEXbnLid+JBfO3I/tKKK56ZJo=";
        cargoHash = "sha256-lSdMpTUihhKDfX+fZHx9DtckY1vweWOpvw4DznXQzxs=";
      };
      scarb = {
        version = "0.5.0";
        srcHash = "sha256-Xts8PefihVtG2xmJ0afcAEPU3bl6RJtSDa27+dGm2kE=";
        cargoHash = "sha256-yAfWNpM5O2kSx3ukOR5BPRWi13LWZiz5/kpDp2k9adE=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.0.1";
        srcHash = "sha256-bqLkCP1hzdOMrVyyyiOZYN0BKPe8OjKMfpFGCr1/anU=";
        archiveHash = "sha256-FqbEbetkoQi3PzedXSqmDCnNO1z2k17ADR/g3Gq+GDg=";
        cargoHash = "sha256-FzQkAlNKFFLK8XmLafm37MvLekGE24BoLliaDpc+44w=";
      };
      scarb = {
        version = "0.5.1";
        srcHash = "sha256-iKASKhvxkev0W3cabHv3xz4wNC7YdWY3Odd0yYxOQic=";
        cargoHash = "sha256-/21XKfDLsAH1+R4YqktgXFQOYA29YtxiaikdksmaTgA=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.0.2";
        srcHash = "sha256-tFWY4bqI+YVVu0E9EPl+c0UAsSn/cjgvEOQtyT9tkYg=";
        archiveHash = "sha256-+bV7b/lvc/SFOOQcIpjKTQcDwdHhlBVwA9boBiDE6yU=";
        cargoHash = "sha256-fnkzR07MIwzjvg2ZRhhzYIUhuidEBZt0mGfxwHyhyVE=";
      };
      scarb = {
        version = "0.5.2";
        srcHash = "sha256-T7GsF57pIpjmMfITbK5sfdO9d02coj5y/ucz00lsORQ=";
        cargoHash = "sha256-AQyBnUg0mIjd0IChPULU3QTdA7QbzYhIVA+3DN3jWGc=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.1.0-rc0";
        srcHash = "sha256-hjDgdO5qDqjw5GlrwhCQnyjtfOUEgVhHGN0qpLGsQxc=";
        archiveHash = "sha256-orCpwAUM+c1Ekjdd+nAxjM4mAutPdqDEwgsQIi7o4/M=";
        cargoHash = "sha256-5wbfO4Hy8c0ZT3GO9ingfCuolCzc9vdJtA2wFc7/z9M=";
      };
      scarb = {
        version = "0.6.0-alpha.0";
        srcHash = "sha256-ddzUsc98hU53D8oCchRrvB/AqoiS1DKuYkTg8liSa7Q=";
        cargoHash = "sha256-6kmSAH5oUoaHh7dzP9PlZf6jPLWeZTHwwgTGMOjQEvg=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.1.0-rc1";
        srcHash = "sha256-Od4LESoNHgQtzYG2JIub5S3ixXgqM76tbVgkxRGsw+Y=";
        archiveHash = "sha256-BU/FRvNnJhGbgLKFka60DdT8TgSE2SEJqLm3OTArcSw=";
        cargoHash = "sha256-bXUgBNxoB41R1G3eWjM/JfftIqivKEIMpxYGyv4/QhY=";
      };
      scarb = {
        version = "0.6.0-alpha.1";
        srcHash = "sha256-4ouFBgSBtOOp/bmuhQRQwpTLVCP4dec5j4p+u5m+jP0=";
        cargoHash = "sha256-eyaOcigHNLLLelexf0SJDptvYSrb5d6f6ifuIOt/++w=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.1.0-rc2";
        srcHash = "sha256-mV43MWycSlvmzkI8UZ3xApOk0iyDPPKwKX91dWddglc=";
        archiveHash = "sha256-Qckk9r3Kji2qbKcv3o1ZQF+H0yguJ0fxEZQEE8qs/eM=";
        cargoHash = "sha256-9+VEEKD1Ml08E3H+ZAKn0waiQriHthQ9nGaeilT6wN4=";
      };
      scarb = {
        version = "0.6.0-alpha.2";
        srcHash = "sha256-efpLFtMOSnIMt4tJj6tcqB9BYRHFlhpWcDCddP2mNNo=";
        cargoHash = "sha256-ubV+kx8v4osBfdjEQuyqoRxlVfFOKvmqomzWg8vXGto=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.1.0-rc4";
        srcHash = "sha256-YR2hocZnOJKuMFolasxJWikXbVPdzBjj6LoUZZYpyaI=";
        archiveHash = "sha256-gmnYnAZrRfODKRR7GBAY2ybEqB+XAffKk1cNfO4Jzsc=";
        cargoHash = "sha256-/pGiKAQZW5uDWWEWWjcpFtjOOb36CH+YFHSFMkBKKLw=";
      };
      scarb = {
        version = "0.6.0-alpha.4";
        srcHash = "sha256-Er+hnwhqO8dYjAS2pMQp7lfU5qD9jXxL8zf2dejPZtE=";
        cargoHash = "sha256-Dxbou24qP8lW9/yN3FUW2glI/rY8rHJHFl0DCLp2VF4=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.1.0";
        srcHash = "sha256-wpQfyeO6sUEfTzA2A5Vvfky58brryf5KgBiX7dcDMBQ=";
        archiveHash = "sha256-p7hG6lGR2mdHaBDxjciJPKJhaI9VII/wlJJ58lOkqdo=";
        cargoHash = "sha256-brCELbAJ5CKWzcTGboKKZn24/aS6BJ5zH53Eu5XS+Rw=";
      };
      scarb = {
        version = "0.6.0";
        srcHash = "sha256-Gre2aa3/sC4Z7gTuMGuLTVn1ZM1TJeWAJ3l2+IGF664=";
        cargoHash = "sha256-VWgHuApX7Tw2OhteU8p7a3y7eZ/zlQhdOmgF5E6LiXk=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.1.1";
        srcHash = "sha256-CgQzS4hxUtLxBTvHt8HGLXVl+trG+e0e0XF6zkr0I+g=";
        archiveHash = "sha256-BhnAvL6k4cpbhcUpfS1xVtCuHZyM/hAPt085857IxZM=";
        cargoHash = "sha256-rJ4vUJDXbJ6ak79j3/AcPULxQkNxz7hSA8vrButx4zM=";
      };
      scarb = {
        version = "0.6.2";
        srcHash = "sha256-5uzMkiCw9Sj1+RrDkHhbAg2J+4nJHlObDluZZebJjqM=";
        cargoHash = "sha256-9sU2ZB2PnHMmRt3h+g0JfJ4ufYXToPmL39eNGAMrSgw=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.2.0";
        srcHash = "sha256-X8CqiikY1/S8/WxrZbcwOB+bz0PJsNpuLWLb+k3+5kw=";
        archiveHash = "sha256-DWe5px8ym+WREIpWDOQ5DeTTt1YMun62KBUMY1WEYrk=";
        cargoHash = "sha256-jrUH3vmTbbxod547JAE5sOSo+FR15XNgVpM15uXAsvg=";
      };
      scarb = {
        version = "0.7.0";
        srcHash = "sha256-0N+ntMSWhXcqEN8p2hYuLjuQtQi8iFlgVtLYKRxycKQ=";
        cargoHash = "sha256-Novq8nQyS2oC3wxNGIgi/Qq2jdSpVpUWJDW6l7ZpL+Y=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.3.0";
        srcHash = "sha256-5UOLfsNgtg5EDDId23ysmWfeqMeh8R2UfMeBAtFCx6s=";
        archiveHash = "sha256-ywF2ngUy5DugDKA4Gju6+5T1rh8HxM1H/GMqw6/DBjk=";
        cargoHash = "sha256-YoPStyPeEqLoUvGLEPwXR8XVhXtb6XwFuPNoDCiT7OA=";
      };
      scarb = {
        version = "2.3.0";
        srcHash = "sha256-XelhTcEZ3xcSZOpB1hC1XNCl/QgOinAICH4IwvEzRjw=";
        cargoHash = "sha256-bdS5tOAUiemgagJZ4CSu0OR2NoGb56Hf0XGC+LwPXLs=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.3.1";
        srcHash = "sha256-2ZT48TJCFPtrI/ZW6mHcFG48/skV3UoYHsFCeh02w8Q=";
        archiveHash = "sha256-MXMlL78TiNIFIV0Wf+2Gbf/FLLUpuQqS8Vb7sO5eXgQ=";
        cargoHash = "sha256-FD8FBKfQR+Q7mBzBtIaEbj+1Yg1jT1y1NwIDxFxOtS8=";
      };
      scarb = {
        version = "2.3.1";
        srcHash = "sha256-08mKCscIFgzGUPUrA9mUmnUBFKmGtGWIMQ+9zfQkKso=";
        cargoHash = "sha256-f9NcUqMWWKlYKfT5ceaK/dNzTqla+JmwCMPVc8z5yVU=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.4.0";
        srcHash = "sha256-5bCPklk9u21/9cZYisszK0Lo7is9+iFrQxve41Fy5hg=";
        archiveHash = "sha256-6fXJfABK1eWjpkUDUODUhxxFEXqVLGU/cR3B2Hqok3E=";
        cargoHash = "sha256-07snC9mzO2o3/ETDO9ag1C2ygexPue4ia0T0M3yapQA=";
      };
      scarb = {
        version = "2.4.0";
        srcHash = "sha256-ECxF/DSnr5Npft2My7lZwTtg83+LerwS/R5zJTI5yvA=";
        cargoHash = "sha256-0kTG87hciRz9B57S3tW1Ffd95/i7q14CHP8WrfuGXBI=";
        cargoLock = null;
      };
    }
    {
      cairo = {
        version = "2.5.0";
        srcHash = "sha256-VtWbXbpMV/ubxLC5amPFn6gxOsTlLVgUz6tBnkT8lmc=";
        archiveHash = "sha256-POotLc/I8lyXmuXmjmt35s36X3IieREefoeyixIl7eE=";
        cargoHash = "sha256-WcmneuHTdjpfo/kDcnEznx0XejCV9M00Lzm4Wt+8OP8=";
      };
      scarb = {
        version = "2.5.0";
        srcHash = "sha256-xc3Gxpj9JmUdjtIlJbKgaAZLQqE3WEv8Bec53eNpB3k=";
        cargoHash = "sha256-wzSQmIL1k8wS523QMtHwXYbOhBvZZbswH6kiICziCwk=";
        cargoLock = null;
      };
    }
  ];

  toolchains =
    builtins.listToAttrs (builtins.map (v: { name = v.cairo.version; value = mkCairo v; }) versions);
in
{
  cairo-bin = (toolchains // {
    stable = toolchains."2.5.0";
    beta = toolchains."2.5.0";
  });
}
