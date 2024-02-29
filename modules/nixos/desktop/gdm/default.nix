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
  cfg = config.randomscanian.desktop.gdm;
  gtkcfg = config.randomscanian.desktop.gtk;
in {
  options.randomscanian.desktop.gdm = with types; {
    enable = mkBoolOpt false "Whether or not to enable gdm";
  };

  config = mkIf cfg.enable {
    randomscanian.system.home.extraOptions = {
      xsession.numlock.enable = true;
    };
    services.xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
      };
    };
  };
}
