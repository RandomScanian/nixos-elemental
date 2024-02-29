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
  cfg = config.randomscanian.gui-apps.gparted;
in {
  options.randomscanian.gui-apps.gparted = with types; {
    enable = mkBoolOpt false "Whether or not to enable GParted.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [gparted];};
}
