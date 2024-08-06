{ config, ... }: {
  imports = [];
  options = {};
  config = {
    age.secrets.cloudflare.file = ./secrets/cloudflare.age;
  };
}
