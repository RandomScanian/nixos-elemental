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
  cfg = config.randomscanian.desktop.lightdm;
  gtkcfg = config.randomscanian.desktop.gtk;
in {
  options.randomscanian.desktop.lightdm = with types; {
    enable = mkBoolOpt false "Whether or not to enable lightdm";
  };

  config = mkIf cfg.enable {
    randomscanian.system.home.extraOptions = {
      xsession.numlock.enable = true;
    };
    services.xserver = {
      enable = true;
      displayManager.lightdm = {
        enable = true;
        greeters.gtk = mkIf gtkcfg.enable {
          iconTheme = {
            name = gtkcfg.icon.name;
            package = gtkcfg.icon.pkg;
          };
          theme = {
            name = gtkcfg.theme.name;
            package = gtkcfg.theme.pkg;
          };
          cursorTheme = {
            name = gtkcfg.cursor.name;
            package = gtkcfg.cursor.pkg;
          };
        };
      };
    };
  };
}
