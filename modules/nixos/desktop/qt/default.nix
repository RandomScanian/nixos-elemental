{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.qt;
in {
  options.randomscanian.desktop.qt = with types; {
    enable = mkBoolOpt false "Whether to customize QT and apply themes.";
  };

  config = mkIf cfg.enable {
  };
}
