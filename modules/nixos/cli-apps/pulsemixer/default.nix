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
  cfg = config.randomscanian.cli-apps.pulsemixer;
in {
  options.randomscanian.cli-apps.pulsemixer = with types; {
    enable = mkBoolOpt false "Whether or not to enable pulsemixer";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [pulsemixer];};
}
