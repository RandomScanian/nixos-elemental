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
  cfg = config.randomscanian.cli-apps.xdotool;
in {
  options.randomscanian.cli-apps.xdotool = with types; {
    enable = mkBoolOpt false "Whether or not to enable xdotool.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [xdotool];
    randomscanian.system.home.extraOptions = {
      randomscanian.cli-apps.xdotool = enabled;
    };
  };
}
