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
    gui-apps = {
      emacs = enabled;
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
  };

  users.users.randomscanian.hashedPassword = "$y$j9T$kI9hpK/554Wty7xFGFfGz/$OyoLajf9qVF/MZIKdY0JTC73AlWUnUEHbaDGBcJkSX2";
  
  #sops.secrets.randomscanianPassword.neededForUsers = true;

  #TEMP
  networking.firewall.enable = false;
  
  system.stateVersion = "23.11";
}
