let
  hoster_user_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPzqvDKDlzJbsGngGIBfoGwKgd3cq3WKoo/W4IhU6iT8";
  admin_user_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC4akMOAh8/uUaHzkkfkNMqTmGSN37cY9HU4KPZAq25Y";
  server_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXSip1TAnfgNrVArz13Hz/ewZs7U0uih049PJRF72Aj";

  users = [ hoster_user_key admin_user_key ];
  systems = [ server_key ];
in {
  "adminPassword.age".publicKeys = systems ++ [ admin_user_key ];
  "hosterPassword.age".publicKeys = systems ++ [ admin_user_key ];
  "cloudflare.age".publicKeys = users ++ systems;
}
