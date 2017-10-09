{...}:
{
  nixpkgs.config = {
    packageOverrides = let
      pkgsUnstable = import (
        fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz
      ) { };
      pkgsMaster = import (
        fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz
      ) { };
      pkgsLocal = import (
        fetchTarball https://github.com/moaxcp/nixpkgs/archive/local.tar.gz
      ) { };
    
    in pkgs:
    rec {
      gradle =
        if pkgs.gradle.name == "gradle-4.2" then
          abort pkgs.gradle.name + " was found in pkgs. No need to upgrade."
        else if pkgsUnstable.gradle.name == "gradle-4.2" then
          pkgsUnstable.gradle
        else if pkgsLocal.gradle.name == "gradle-4.2" then
          pkgsLocal.gradle
        else
          abort "could not find gradle-4.2";
    };
  };
}
