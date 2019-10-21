{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import <nur> {
      inherit pkgs;
    };
  };

  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./networking.nix
      <home-manager/nixos>
      ./user.nix
      ./packages.nix
      ./services.nix
      ./bash.nix
    ];

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  fonts.fonts = with pkgs; [ terminus_font terminus_font_ttf ];
  fonts.enableDefaultFonts = true;

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };


  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.optimus_prime = {
    enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.videoDrivers = [ "nvidiaLegacy390" ];
  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.bluetooth.enable = true;

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
