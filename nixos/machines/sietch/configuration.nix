{ config, pkgs,  ... }:

{
  imports =
    [
      ./common/common.nix
      ./common/cj.nix
      ./common/openssh.nix
    ];

  networking.hostName = "sietch";
  networking.wireless.enable = true;
  networking.interfaces.wlp2s0.useDHCP = true;

  # Tell systemd-boot our drive is encrypted
  boot.initrd.luks.devices = {
    crypt = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
      allowDiscards = true;
    };
  }

  system.stateVersion = "20.09";
}
