#!/bin/sh

select machine in ~/Code/dotfiles/nixos/machines/*/; do break; done

# Copy configuration.nix
ln -sf "${machine}/configuration.nix" /etc/nixos/configuration.nix

# Copy hardware_configuration.nix if it exists
if [ -e "${machine}/hardware_configuration.nix" ]; then
  ln -sf "${machine}/hardware_configuration.nix" /etc/nixos/hardware_configuration.nix
fi

# Copy in common nix files
ln -sf ~/Code/dotfiles/nixos/common /etc/nixos/common
