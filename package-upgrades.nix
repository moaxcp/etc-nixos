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
        jbake = pkgsLocal.jbake;                
    };
  };
}
