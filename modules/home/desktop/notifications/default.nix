{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.keybindings;
in {
  options.randomscanian.desktop.notficiations = with types; {
    enable = mkEnableOption "Whether or not to enable notifications";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [libnotify];
    services.dunst = {
      enable = true;
      iconTheme = config.gtk.iconTheme;
      settings = {
        global = {
          origin = "top-right";
          font = "JetBrainsMono Nerd Font 9";
        };
        urgency_normal = {
          timeout = 10;
        };
      };
    };
  };
}
