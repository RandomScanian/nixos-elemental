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
  cfg = config.randomscanian.gui-apps.vlc;
in {
  options.randomscanian.gui-apps.vlc = with types; {
    enable = mkBoolOpt false "Whether or not to enable vlc.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vlc
    ];
    randomscanian.system.home.extraOptions = {
      randomscanian.gui-apps.vlc = enabled;
    };
  };
}
