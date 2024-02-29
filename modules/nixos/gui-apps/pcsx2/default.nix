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
  cfg = config.randomscanian.gui-apps.pcsx2;
in {
  options.randomscanian.gui-apps.pcsx2 = with types; {
    enable = mkBoolOpt false "Whether or not to enable pcsx2.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [pcsx2];};
}
