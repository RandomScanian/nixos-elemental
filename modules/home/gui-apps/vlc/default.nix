{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.gui-apps.vlc;
in {
  options.randomscanian.gui-apps.vlc = {
    enable = mkEnableOption "Whether or not to enable vlc";
  };

  config = mkIf cfg.enable {home.packages = with pkgs; [vlc];};
}
