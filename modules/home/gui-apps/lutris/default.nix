{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.gui-apps.lutris;
in {
  options.randomscanian.gui-apps.lutris = {
    enable = mkEnableOption "Whether or not to enable lutris";
  };

  config = mkIf cfg.enable {home.packages = with pkgs; [lutris];};
}
