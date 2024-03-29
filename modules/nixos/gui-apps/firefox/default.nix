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
  cfg = config.randomscanian.gui-apps.firefox;
in {
  options.randomscanian.gui-apps.firefox = with types; {
    enable = mkBoolOpt false "Whether or not to enable firefox";
    verticalTabs = mkBoolOpt true "Whether or not to enable vertical tabs.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [firefox];
    randomscanian.system.home.extraOptions = {
      randomscanian.gui-apps.firefox = {
        enable = true;
        verticalTabs = cfg.verticalTabs;
      };
    };
  };
}
