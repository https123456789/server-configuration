{ config, lib, pkgs, ... }: {
  environment.systemPackages = [ pkgs.git ];

  systemd.services.personal-website = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" "home-server.service" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    path = [ pkgs.git ];
    serviceConfig = {
      ExecStart = "${pkgs.nix}/bin/nix run";
      WorkingDirectory = "/home/hoster/services/personal-website";
      User = "hoster";
    };
  };
}
