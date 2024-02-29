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
  cfg = config.randomscanian.gui-apps.tilix;
in {
  options.randomscanian.gui-apps.tilix = with types; {
    enable = mkBoolOpt false "Whether or not to enable Tilix";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [tilix];
  };
}
