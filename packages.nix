{config, pkgs, ...}:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    borgbackup
    file
    glxinfo
    git
    google-chrome
    htop
    jdk
    lsof
    minecraft
    nixops
    nox
    pavucontrol
    psmisc
    screen
    tree
    unzip
    usbutils
    utillinux
    (pkgs.callPackage ./vim.nix {})
    zip
  ];
}
