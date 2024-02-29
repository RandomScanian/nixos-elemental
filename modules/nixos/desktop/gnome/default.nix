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
  cfg = config.randomscanian.desktop.gnome;
in {
  options.randomscanian.desktop.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to enable Gnome";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome = {
      enable = true;
    };
    programs.dconf.enable = mkForce true;
    services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
    randomscanian = {
      desktop = {
        wallpapers = enabled;
      };
      system.home.extraOptions = {
        randomscanian.desktop.gnome = enabled;
      };
    };
  };
}
