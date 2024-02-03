{pkgs, lib, config, ...}:

with lib;
with lib.randomscanian;
{
  imports = [./hardware.nix];

  randomscanian = {
    archetypes = {
      desktop = enabled;
      gaming = enabled;
    };
    services = {
      ssh = enabled;
    };
    system = {
      boot = {
        EFI = true;
        device = "/boot";
      };
      user = {
        name = "randomscanian";
        email = "randomscanian@protonmail.com";
        shell = "fish";
      };
    };
    desktop = {
      xmonad = enabled;
    };
  };

  #TEMP
  networking.firewall.enable = false;

  
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
  services.xserver.videoDrivers = [ "nvidia" ];
  
  
  system.stateVersion = "23.11";
}
