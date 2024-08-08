{ config, lib, pkgs, ... }: {
  environment.systemPackages = [ pkgs.docker-compose ];

  systemd.services.miniflux = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" "home-server.service" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    path = [ pkgs.docker-compose ];
    serviceConfig = {
      ExecStart = "${pkgs.docker}/bin/docker compose up";
      WorkingDirectory = "/home/hoster/services/miniflux";
      User = "hoster";
    };
  };
}
