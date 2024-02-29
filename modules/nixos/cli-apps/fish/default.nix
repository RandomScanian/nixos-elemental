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
  cfg = config.randomscanian.cli-apps.fish;
in {
  options.randomscanian.cli-apps.fish = with types; {
    enable = mkBoolOpt false "Whether or not to enable the fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
    randomscanian.system.home.extraOptions = {
      randomscanian.cli-apps.fish = enabled;
    };
  };
}
