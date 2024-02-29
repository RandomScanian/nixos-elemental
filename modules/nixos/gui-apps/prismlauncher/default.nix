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
  cfg = config.randomscanian.gui-apps.prismlauncher;
in {
  options.randomscanian.gui-apps.prismlauncher = with types; {
    enable = mkBoolOpt false "Whether or not to enable Prismlauncher.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [prismlauncher];};
}
