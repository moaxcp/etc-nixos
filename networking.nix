{...}:
{
  networking = {
    hostName = "n2";
    useDHCP = false;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ ];
    };
  };
}
