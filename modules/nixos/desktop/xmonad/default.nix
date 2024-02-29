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
  cfg = config.randomscanian.desktop.xmonad;
in {
  options.randomscanian.desktop.xmonad = with types; {
    enable = mkBoolOpt false "Whether or not to enable XMonad";
  };

  config = mkIf cfg.enable {
    services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
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
        randomscanian.desktop.xmonad = enabled;
      };
    };
  };
}
