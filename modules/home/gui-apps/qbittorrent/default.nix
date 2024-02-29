{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.gui-apps.qbittorrent;
in {
  options.randomscanian.gui-apps.qbittorrent = {
    enable = mkEnableOption "Whether or not to enable qbittorrent";
  };

  config = mkIf cfg.enable {home.packages = with pkgs; [qbittorrent];};
}
