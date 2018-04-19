self: super:
let
  pkgsUnstable = import (
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
  ) { };
  inherit (self) fetchzip;
in {
  jbake = super.jbake.overrideAttrs (old: rec {
    version = "2.6.1";
    name = "jbake-${version}";
    src = fetchzip {
        url = "https://dl.bintray.com/jbake/binary/${name}-bin.zip";
        sha256 = "0zlh2azmv8gj3c4d4ndivar31wd42nmvhxq6xhn09cib9kffxbc7";
    };
  });
}
