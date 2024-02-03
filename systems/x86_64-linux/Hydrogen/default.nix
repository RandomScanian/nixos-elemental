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
    hardware = {
      nvidia = enabled;
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
  
  system.stateVersion = "23.11";
}
