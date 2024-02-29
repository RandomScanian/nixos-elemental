{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.gnome;
  xdotool = "${pkgs.xdotool}/bin/xdotool";
  calc = "${pkgs.calc}/bin/calc";
in {
  options.randomscanian.desktop.gnome = {
    enable = mkEnableOption "Whether or not to enable gnome";
  };

  config = mkIf cfg.enable {
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
    home.packages = with pkgs.gnomeExtensions; [
      appindicator
      vertical-workspaces
      enhanced-osk
    ];
  };
}
