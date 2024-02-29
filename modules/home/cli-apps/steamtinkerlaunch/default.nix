{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.cli-apps.steamtinkerlaunch;
in {
  options.randomscanian.cli-apps.steamtinkerlaunch = with types; {
    enable = mkEnableOption "Whether or not to enable steamtinkerlaunch.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      steamtinkerlaunch
    ];
  };
}
