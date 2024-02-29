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
  cfg = config.randomscanian.gui-apps.rofi;
in {
  options.randomscanian.gui-apps.rofi = with types; {
    enable = mkBoolOpt false "Whether or not to enable Rofi";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rofi
      randomscanian.dmenu
    ];
    randomscanian.system.home.extraOptions = {
      randomscanian.gui-apps.rofi = enabled;
    };
  };
}
