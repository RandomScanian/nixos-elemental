{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.gui-apps.prismlauncher;
in {
  options.randomscanian.gui-apps.prismlauncher = {
    enable = mkEnableOption "Whether or not to enable prismlauncher";
  };

  config = mkIf cfg.enable {home.packages = with pkgs; [prismlauncher];};
}
