{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.cli-apps.xdotool;
in {
  options.randomscanian.cli-apps.xdotool = {
    enable = mkEnableOption "Whether or not to enable xdotool";
  };

  config = mkIf cfg.enable {home.packages = with pkgs; [xdotool];};
}
