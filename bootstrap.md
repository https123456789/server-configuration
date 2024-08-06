# Bootstrapping The Configuration

This guide assumes that the system is a fresh install of NixOS (minimal).

## Getting The Configuration

```
nix-shell -p git stow
sudo mkdir /stow
sudo chown admin:users /stow
cd /stow
git init
git remote add origin https://github.com/https123456789/server-configuration.git
git pull origin main
```

## Add Nix Channels

```
sudo nix-channel --add https://github.com/ryantm/agenix/archive/main.tar.gz agenix
sudo nix-channel --update
```

## Apply The Configuration

```
./stow.sh setup
```

## Rebuild The System

```
sudo nixos-rebuild switch
```
