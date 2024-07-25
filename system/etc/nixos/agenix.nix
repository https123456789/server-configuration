{ config, ... }: {
  imports = [];
  options = {};
  config = {
    age.secrets.cloudflare.file = ./secrets/cloudflare.age;
    age.secrets.adminPassword.file = ./secrets/adminPassword.age;
    age.secrets.hosterPassword.file = ./secrets/hosterPassword.age;
  };
}
