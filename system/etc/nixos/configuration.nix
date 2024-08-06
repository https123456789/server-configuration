{ config, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix # each machine will have a different hardware configuration
      <agenix/modules/age.nix>
      ./cloudflare.nix
      ./agenix.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.admin = {
      isNormalUser = true;
      description = "Admin";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };
    users.hoster = {
      isNormalUser = true;
      description = "Services Hoster";
      extraGroups = [];
      packages = with pkgs; [];
    };
  };

  # Automatically log in at the virtual consoles.
  services.getty.autologinUser = "hoster";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Storage optimization and garbage collection
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     neovim
     curl
     fastfetch
     btop
     git
     thermald
     stow
     avahi
     cloudflared
     (pkgs.callPackage <agenix/pkgs/agenix.nix> {})
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };

  services.thermald.enable = true;

  services.avahi = {
    enable = true;
    nssmdns6 = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
      addresses = true;
    };
  };

  # services.cloudflared = {
  #  enable = true;
  #  user = "hoster";
  #  tunnels."nixos-server" = {
  #    credentialsFile = "${config.users.users.hoster.home}/.cloudflared/nixos-server.json";
  #    default = "http_status:404";
  #    ingress."b0x207.dev" = "http://localhost:3000";
  #  };
  #};

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 443 ];
    allowedUDPPorts = [ 22 80 443 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
