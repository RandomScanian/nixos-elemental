{lib, config, pkgs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.cli-apps.tmux;
in {
  options.randomscanian.cli-apps.tmux = {
    enable = mkEnableOption "Whether or not to enable custom Tmux config";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux
    ];
  };
}
