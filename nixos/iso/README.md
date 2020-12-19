# NixOS iso
We'll use docker to set up a temporary nix system and produce an iso by running:
```$ ./docker_build.sh```

## Creating install media
```
$ diskutil list
...
$ diskutil unmountDisk /dev/diskn
$ sudo dd if=result/iso/nixos*.iso of=INSTALL_LOCATION bs=4m
```

## Installing
Boot to the install media and run 
```$ ./install.sh```
