{pkgs, ...}:
{
  services.borgbackup.jobs = {
    rootBackup = {
      paths = "/";
      exclude = [ "/nix" "/data" ];
      repo = "/data/borg";
      encryption = {
        mode = "repokey";
        passCommand = "cat /etc/nixos/borg_passphrase";
      };
      compression = "auto,lzma";
      startAt = "weekly";
      extraCreateArgs = "--stats --progress --one-file-system";
    };
  };
}
