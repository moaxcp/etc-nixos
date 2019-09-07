{...}:
{
  users.extraGroups.john.gid = 1000;
  users.extraUsers.john = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/john";
    group = "john";
    extraGroups = [ "users" "wheel" "networkmanager" ];
  };
}
