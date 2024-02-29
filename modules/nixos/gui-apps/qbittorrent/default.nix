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
  cfg = config.randomscanian.gui-apps.qbittorrent;
in {
  options.randomscanian.gui-apps.qbittorrent = with types; {
    enable = mkBoolOpt false "Whether or not to enable qbittorrent.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [qbittorrent];
    randomscanian.system.home.extraOptions = {
      randomscanian.gui-apps.qbittorrent = enabled;
    };
  };
}
