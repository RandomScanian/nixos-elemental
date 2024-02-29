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
  cfg = config.randomscanian.cli-apps.eza;
in {
  options.randomscanian.cli-apps.eza = with types; {
    enable = mkBoolOpt false "Whether or not to enable eza";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [eza];
    randomscanian.system.home.extraOptions = {
      randomscanian.cli-apps.eza = enabled;
    };
  };
}
