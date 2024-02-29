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
  cfg = config.randomscanian.cli-apps.just;
in {
  options.randomscanian.cli-apps.just = with types; {
    enable = mkBoolOpt false "Whether or not to enable just.";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [just];};
}
