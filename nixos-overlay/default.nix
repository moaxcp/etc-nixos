self: super:
let
  pkgsUnstable = import <nixpkgs-unstable> { };
  inherit (self) fetchzip;
  //for pkgsUnstable make function to compare versions and fail if pkgsUnstable version matches.
in {
  visualvm = pkgsUnstable.visualvm;
  jbake = pkgsUnstable.jbake;
}
