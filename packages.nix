{config, pkgs, ...}:
{
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
      nur = import <nur> {
        inherit pkgs;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    borgbackup
    glxinfo
    git
    htop
    jdk
    lsof
    nixops
    nox
    psmisc
    screen
    tree
    unetbootin
    unzip
    usbutils
    utillinux
    #vim config
    (pkgs.callPackage ./vim.nix {})
    zip
  ];
}
