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
  cfg = config.randomscanian.desktop.i3;
in {
  options.randomscanian.desktop.i3 = with types; {
    enable = mkBoolOpt false "Whether or not to enable i3";
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager.i3 = {
      enable = true;
    };
    randomscanian = {
      gui-apps = {
        rofi = enabled;
      };
      services = {
        polybar = enabled;
      };
      desktop = {
        wallpapers = enabled;
        keybindings = enabled;
      };
      system.home.extraOptions = {
        randomscanian.desktop.i3 = enabled;
      };
    };
  };
}
