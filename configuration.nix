{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      <nixos-hardware/common/pc/laptop>
      <nixos-hardware/common/pc/ssd>
      ./hardware.nix
      ./boot.nix
      ./system.nix
      ./networking.nix
      ./packages.nix
      ./bash.nix
      ./services.nix
      ./user.nix
    ];
    services.thermald.enable = true;
}

