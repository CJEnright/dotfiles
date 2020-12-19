{ config, pkgs,  ... }:

{
  imports =
    [
      ./common/common.nix
      ./common/cj.nix
      ./common/openssh.nix
    ];

  networking.hostName = "mentat";
  networking.interfaces.enp4s0.useDHCP = true;

  # Tell systemd-boot our drive is encrypted
  boot.initrd.luks.devices = {
    crypt = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
      allowDiscards = true;
    };
  };

  users.users.cj = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker" ];
  };

  # Add ssh key for cj
  users.users.cj.openssh.authorizedKeys.keyFiles = [
    /etc/ssh_pub_key
  ];

  system.stateVersion = "20.09";
}
