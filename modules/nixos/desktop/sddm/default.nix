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
  cfg = config.randomscanian.desktop.sddm;
  gtkcfg = config.randomscanian.desktop.gtk;
in {
  options.randomscanian.desktop.sddm = with types; {
    enable = mkBoolOpt false "Whether or not to enable sddm";
  };

  config = mkIf cfg.enable {
    randomscanian.system.home.extraOptions = {
      xsession.numlock.enable = true;
    };
    services.xserver = {
      enable = true;
      displayManager.sddm = {
        enable = true;
      };
    };
  };
}
