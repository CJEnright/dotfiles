{ config, pkgs,  ... }:

{
  # sshd_config settings with a focus on having a reasonable amount security.
  services.openssh = {
    enable = true;

    # Don't allow X11 forwarding
    forwardX11 = false;

    # Don't let root login over SSH
    permitRootLogin = "no";

    # Use SSH keys instead of passwords
    passwordAuthentication = false;
    challengeResponseAuthentication = false;

    # Using settings from https://stribika.github.io/2015/01/04/secure-secure-shell.html
    kexAlgorithms = [
      "curve25519-sha256@libssh.org",
      "diffie-hellman-group-exchange-sha256"
    ];

    ciphers = [
      "chacha20-poly1305@openssh.com",
      "aes256-gcm@openssh.com",
      "aes128-gcm@openssh.com",
      "aes256-ctr",
      "aes192-ctr",
      "aes128-ctr"
    ];

    macs = [
      "hmac-sha2-512-etm@openssh.com",
      "hmac-sha2-256-etm@openssh.com",
      "umac-128-etm@openssh.com",
      "hmac-sha2-512",
      "hmac-sha2-256",
      "umac-128@openssh.com"
    ];
  };
}
