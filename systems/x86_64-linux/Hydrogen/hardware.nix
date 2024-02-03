{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.blacklistedKernelModules = [ "nouveau" ];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  fileSystems."/" = {
    device = "/dev/disk/by-label/HYROOT";
    fsType = "btrfs";
    options = ["subvol=root"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-label/HYROOT";
    fsType = "btrfs";
    options = ["subvol=home"];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-label/HYROOT";
    fsType = "btrfs";
    options = ["subvol=swap"];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-label/HYROOT";
    fsType = "btrfs";
    options = ["subvol=persist"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/HYBOOT";
    fsType = "vfat";
  };
  
  swapDevices = [
    {
      device = "/swap/swap";
      size = 16*1024;
    }
    {
      device = "/swap/swapfile";
      size = 16*1024;
    }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
