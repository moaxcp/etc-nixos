{pkgs, ...}:
{
  systemd.services.obnam = {
    description = "system backup with obnam";
    script = "PATH=${pkgs.obnam}/bin:${pkgs.coreutils}/bin ${pkgs.stdenv.shell} ${./obnam.sh}";
  };

  systemd.timers.obnam = {
    description = "run obnam every day";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  environment.etc."obnam.conf" = {
    enable = true;
    text = ''
      [config]
      repository = /data/obnam/all
      client-name = n1
      root = /
      one-file-system = yes
      exclude = /data
    '';
  };
}
