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
  cfg = config.randomscanian.desktop.sway;
in {
  options.randomscanian.desktop.sway = with types; {
    enable = mkBoolOpt false "Whether or not to enable sway";
  };

  config = mkIf cfg.enable {
    # services.xserver.windowManager.sway = {
    #   enable = true;
    # };
    randomscanian = {
      gui-apps = {
        #wofi = enabled;
      };
      services = {
        #waybar = enabled;
      };
      desktop = {
        #wallpapers = enabled;
        #keybindings = {
        #enable = true;
        #wayland = true;
        #};
      };
      system.home.extraOptions = {
        #randomscanian.desktop.sway = enabled;
      };
    };
  };
}
