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
  cfg = config.randomscanian.gui-apps.lutris;
in {
  options.randomscanian.gui-apps.lutris = with types; {
    enable = mkBoolOpt false "Whether or not to enable Lutris.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [lutris];
    randomscanian.system.home.extraOptions = {
      randomscanian.gui-apps.lutris = enabled;
    };
  };
}
