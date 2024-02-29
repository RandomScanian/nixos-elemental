{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.menus;
in {
  options.randomscanian.desktop.menus = {
    enable = mkEnableOption "Whether or not to enable custom destkop menus";
  };

  config = mkIf cfg.enable {
  };
}
