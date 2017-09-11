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
    
    in pkgs:
    rec {
      visualvm = pkgsUnstable.visualvm;
      notion = pkgsMaster.notion;
    };
  };
}
