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
  cfg = config.randomscanian.cli-apps.steamtinkerlaunch;
in {
  options.randomscanian.cli-apps.steamtinkerlaunch = with types; {
    enable = mkBoolOpt false "Whether or not to enable steamtinkerlaunch.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [steamtinkerlaunch];
    randomscanian.system.home.extraOptions = {
      randomscanian.cli-apps.steamtinkerlaunch = enabled;
    };
  };
}
