let
  hoster_user_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPzqvDKDlzJbsGngGIBfoGwKgd3cq3WKoo/W4IhU6iT8";
  admin_user_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA2svwV3rPJ9+fZgSQUV5zjjSHP8n8dpMZq4YIrF1GUz";
  server_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA4ow4NnnTr2QioCPNyAj9vyRPZvDULRz6M54wdZqqBc";

  users = [ hoster_user_key admin_user_key ];
  systems = [ server_key ];
in {
  "adminPassword.age".publicKeys = systems ++ [ admin_user_key ];
  "hosterPassword.age".publicKeys = systems ++ [ admin_user_key ];
  "cloudflare.age".publicKeys = users ++ systems;
}
