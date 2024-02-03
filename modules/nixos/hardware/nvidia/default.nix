{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.hardware.nvidia;
in
{
  options.randomscanian.hardware.nvidia = with types; {
    enable = mkBoolOpt false "Whether or not to enable the Nvidia proprietary driver.";
  };

  config = mkIf cfg.enable {
    boot.blacklistedKernelModules = [ "nouveau" ];
    services.xserver.videoDrivers = [ "nvidia" ];
    
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
