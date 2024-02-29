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
  cfg = config.randomscanian.gui-apps.bitwarden;
in {
  options.randomscanian.gui-apps.bitwarden = with types; {
    enable = mkBoolOpt false "Whether or not to enable Bitwarden";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [bitwarden];};
}
