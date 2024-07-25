{ config, lib, pkgs, ... }: {
  environment.systemPackages = [ pkgs.cloudflared ];
  users.users.cloudflared = {
    group = "cloudflared";
    isSystemUser = true;
  };
  users.groups.cloudflared = { };

  systemd.services.home-server = {
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" "systemd-resolved.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run";
      EnvironmentFile = builtins.toString(config.age.secrets.cloudflare.path);
      Restart = "always";
      User = "cloudflared";
      Group = "cloudflared";
    };
  };

}
