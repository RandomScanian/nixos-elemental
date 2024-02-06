{lib, config, pkgs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.cli-apps.comma;
in {
  options.randomscanian.cli-apps.comma = {
    enable = mkEnableOption "Whether or not to enable comma";;
  };

  config = mkIf cfg.enable {
    home.packages = pkgs.randomscanian [
      comma
    ];
  };
}
