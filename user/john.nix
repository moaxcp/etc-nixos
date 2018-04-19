{ config, pkgs, ... }:

{
  users.extraGroups.john.gid = 1000;
  users.extraUsers.john = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/john";
    group = "john";
    extraGroups = [ "users" "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  environment.etc = {
    "user/john/.Xresources".source = ./Xresources;
    "user/john/.notion/cfg_notion.lua".source = ./notion/cfg_notion.lua;
    "user/john/.notion/cfg_notioncore.lua".source = ./notion/cfg_notioncore.lua;
    "user/john/.notion/cfg_tiling.lua".source = ./notion/cfg_tiling.lua;
    "user/john/.notion/cfg_statusbar.lua".source = ./notion/cfg_statusbar.lua;
    "user/john/.notion/statusbar_wsname.lua".source = ./notion/statusbar_wsname.lua;
    "user/john/.groovy/grapeConfig.xml".source = ./groovy/grapeConfig.xml;
  };
}
