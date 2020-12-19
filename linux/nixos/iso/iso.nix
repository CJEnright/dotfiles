# This creates a custom nix iso.
# See https://nixos.wiki/wiki/Creating_a_NixOS_live_CD
# For instructions to create the iso, see README.md

{ config, pkgs, sshPubKeyPath, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];

  # Add SSH key from host generating iso as authorized key on target
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  environment.etc = {
    "install.sh" = {
      source = ./install.sh;
      mode = "0700";
    };

    "ssh_pub_key" = {
      source = /ssh_pub_key;
      mode = "0760";
    };
  };
}
