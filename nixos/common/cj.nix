# Set up a user called cj with sudo privileges.
{ config, pkgs, ... }:

{
  # Make sure to set `passwd` on first boot!
  users.users.cj = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Give cj sudo
  };
}
