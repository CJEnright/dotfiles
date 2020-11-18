# See https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
# 
# This creates a custom nix iso.
# common.nix contains configs that all hardware uses. To actually build an iso
# you should symlink a *.nix file from ../machines. For example:
# `$ ln -sf ../machines/sietch.nix configuration.nix`
# After that you can build the iso:
#
# If you're running this on a 64 bit linux system and are targeting a 64 bit
# linux system, then you can run:
# `$ nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix`
#
# Otherwise, you can use docker to set up a temporary nix system and produce an
# iso by running:
# `$ ./docker_build.sh`

{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  # I wanted to make this configurable via an --arg passed to nix-build, but
  # turns out nix sucks.
  # ANYWAY, include the host ssh key in the iso
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keyFiles = [
    ~/.ssh/id_ed25519.pub
  ];

  environment.etc = {
    "install.sh" = {
      source = ./install.sh;
      mode = "0700";
    };
  };
}
