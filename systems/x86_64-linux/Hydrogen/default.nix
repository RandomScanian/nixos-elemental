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
      desktop = enabled;
      gaming = enabled;
    };
    gui-apps = {
      emacs = enabled;
      qbittorrent = enabled;
    };
    cli-apps = {
      xdotool = enabled;
    };
    services = {
      ssh = enabled;
      bluetooth = enabled;
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

  # TEMP: test wayland;
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS=["1"];
  };
  programs.hyprland = {
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  
  users.users.randomscanian.hashedPassword = "$y$j9T$kI9hpK/554Wty7xFGFfGz/$OyoLajf9qVF/MZIKdY0JTC73AlWUnUEHbaDGBcJkSX2";
  services.gvfs.enable = true;

  boot.supportedFilesystems = [ "ntfs" ];
  
  #sops.secrets.randomscanianPassword.neededForUsers = true;

  #TEMP
  networking.firewall.enable = false;

  system.stateVersion = "23.11";
}
