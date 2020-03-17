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
    lsof
    nixops
    nox
    psmisc
    tree
    unetbootin
    unzip
    usbutils
    utillinux
    #vim config
    (pkgs.callPackages ./vim.nix {})
    zip
  ];
}
