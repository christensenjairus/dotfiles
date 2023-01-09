# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6efe7504-0aa1-4964-87b6-9e10d4d60297";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/800F-3A66";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/12b37c80-c437-4876-a479-46fbf635a5c5"; }
    ];

  # SWAP OPTIONS (if not in hardware-configuration.nix)
    # ZRAM (Use on VMs)
      # zramSwap.enable = true;
      # zramSwap.memoryPercent = 50;
    # Swapfile (Use on Bare Metal)
      # swapDevices = [ { device = "/var/swapfile"; size = 18022; } ]; # 1.1 times the RAM.
      # boot.resumeDevice = "/dev/disk/by-uuid/7aaf0ec8-c230-44e4-8ed2-f4e78e2e6a4a";
      # boot.kernelParams = [ "resume_offset=32194560" ]; # find using filefrag -v /var/swapfile and its the first physical offset listed. Changes every time file is remade.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp61s0.useDHCP = lib.mkDefault true;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22 3389 5432 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764;} # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  networking.hostName = "Ares-NixOS"; # Define your hostname.

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
