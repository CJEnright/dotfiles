{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ../hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Allow non-free software
  nixpkgs.config.allowUnfree = true;
  hardware.enableRedistributableFirmware = true;

  # Enable trim (imagine not using an SSD)
  services.fstrim.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };
}
