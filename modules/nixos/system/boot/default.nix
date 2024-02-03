{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.system.boot;
in
{
  options.randomscanian.system.boot = with types; {
    grub = mkBoolOpt true "Whether or not to use grub";
    EFI = mkBoolOpt true "Whether or not the system use EFI";
    device = mkOpt str "/boot" "The device or mount point for grub";
    efiInstallAsRemovable = mkBoolOpt false "whether or not to install grub as removable";
  };

  config = {
    boot.loader = {
      efi = mkIf cfg.EFI {
        canTouchEfiVariables = true;
        efiSysMountPoint = cfg.device;
      };
      grub = {
        enable = cfg.grub;
        efiSupport = cfg.EFI;
        efiInstallAsRemovable = cfg.efiInstallAsRemovable;
        device = (if cfg.EFI then "nodev" else cfg.device);
        memtest86.enable = true;
      };
      systemd-boot = {
        enable = (if cfg.grub == false then true else false);
        memtest86.enable = true;
        editor = false;
      };
    };
  };
}
