{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.randomscanian; {
  imports = [./hardware.nix];

  randomscanian = {
    archetypes = {
      tablet = enabled;
    };
    gui-apps = {
      emacs = enabled;
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
  };
  
  #TEMP
  networking.firewall.enable = false;
  
  system.stateVersion = "23.05";
}
