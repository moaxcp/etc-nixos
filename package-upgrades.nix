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
      visualvm =
        if pkgs.visualvm.name == "visualvm-1.3.9" then
          abort pkgs.visualvm.name + " was found in pkgs. No need to upgrade."
        else if pkgsUnstable.visualvm.name == "visualvm-1.3.9" then
          pkgsUnstable.visualvm
        else if pkgsLocal.visualvm.name == "visualvm-1.3.9" then
          pkgsLocal.visualvm
        else
          abort "could not find visualvm-1.3.9";
      notion = 
        if pkgs.notion.name == "notion-3-2017050501" then
          abort pkgs.notion.name + " was found in pkgs. No need to upgrade."
        else if pkgsUnstable.notion.name == "notion-3-2017050501" then
          pkgsUnstable.notion
        else if pkgsLocal.notion.name == "notion-3-2017050501" then
          pkgsLocal.notion
        else
          abort "could not find notion-3-2017050501";
      groovy =
         if pkgs.groovy.name == "groovy-2.4.12" then
          abort pkgs.groovy.name + " was found in pkgs. No need to upgrade."
        else if pkgsUnstable.groovy.name == "groovy-2.4.12" then
          pkgsUnstable.groovy
        else if pkgsLocal.groovy.name == "groovy-2.4.12" then
          pkgsLocal.groovy
        else
          abort "could not find groovy-2.4.12";
      obnam =
         if pkgs.obnam.name == "obnam-1.22" then
          abort pkgs.obnam.name + " was found in pkgs. No need to upgrade."
        else if pkgsUnstable.obnam.name == "obnam-1.22" then
          pkgsUnstable.obnam
        else if pkgsLocal.obnam.name == "obnam-1.22" then
          pkgsLocal.obnam
        else
          abort "could not find obnam-1.22";

    };
  };
}
