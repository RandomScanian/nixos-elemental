{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.hardware.nvidia;
in {
  options.randomscanian.hardware.nvidia = with types; {
    enable = mkBoolOpt false "Whether or not to enable the Nvidia proprietary driver.";
    enableSpecialisation = mkBoolOpt true "Whether or not to enable the Specialisation for nouveau driver.";
  };

  config = mkIf cfg.enable {
    boot.blacklistedKernelModules = ["nouveau"];
    services.xserver.videoDrivers = ["nvidia"];

    specialisation.nouveau = mkIf cfg.enableSpecialisation {
      configuration = {
        boot.blacklistedKernelModules = ["nvidia"];
        services.xserver.videoDrivers = ["nouveau"];
        hardware.nvidia = lib.mkForce {};
      };
    };

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      nvidiaSettings = true;
    };
  };
}
