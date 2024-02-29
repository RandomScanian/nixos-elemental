{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.gui-apps.rofi;
in {
  options.randomscanian.gui-apps.rofi = {
    enable = mkEnableOption "Whether or not to enable custom rofi config";
  };

  config = mkIf cfg.enable {
    randomscanian.desktop.keybindings.extraKeybindings = {
      "super + p" = "rofi -show combi";
    };
    xdg.configFile."rofi/theme.rasi".source = "${inputs.dracula-rofi}/theme/config1.rasi";
    xdg.configFile."rofi/config.rasi".text = ''
      configuration {
        cycle: true;
        font: "JetBrainsMono Nerd Font";
        combi-modes: [drun,run,window,ssh];
        modes: [window,drun,run,ssh,combi];
        terminal: "${pkgs.alacritty}/bin/alacritty";
        location: 0;
        xoffset: 0;
        yoffset: 0;
      }
      @theme "./theme.rasi"
    '';
  };
}
