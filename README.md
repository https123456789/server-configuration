# My NixOS Server Configuration

Just a git repo with my configuration for my NixOS server.

## Bootstrapping The Configuration

We'll assume that the system has a fresh install of NixOS (minimal).

```
nix-shell -p git stow
sudo mkdir /stow
sudo chown admin:users /stow
cd /stow
git init
git remote add origin https://github.com/https123456789/server-configuration.git
git pull origin main
```

## Apply The Configuration

```
./stow.sh setup
```

## Remove The Configuration

```
./stow.sh teardown
```
