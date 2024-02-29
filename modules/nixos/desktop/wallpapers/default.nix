{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.wallpapers;
in {
  options.randomscanian.desktop.wallpapers = with types; {
    enable = mkBoolOpt false "Whether or not to apply custom wallpapers.";
  };

  config = mkIf cfg.enable {
    randomscanian.system.home.extraOptions = {
      randomscanian.desktop.wallpapers = enabled;
    };
  };
}
