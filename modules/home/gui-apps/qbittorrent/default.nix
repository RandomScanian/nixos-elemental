{lib, config, pkgs, inputs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.gui-apps.qbittorent;
in {
  options.randomscanian.gui-apps.qbittorent = {
    enable = mkEnableOption "Whether or not to enable qbittorent";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qbittorrent
    ];
  };
}
