{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.i3;
  calc = "${pkgs.calc}/bin/calc";
in {
  options.randomscanian.desktop.i3 = {
    enable = mkEnableOption "Whether or not to enable custom i3 config";
  };

  config = mkIf cfg.enable {
    xsession.enable = true;
    randomscanian.desktop.keybindings = {
      enable = true;
      extraKeybindings = {
        "super + {1-9}" = "i3-msg workspace number {1-9}";
        "super + shift + {1-9}" = "move container to workspace number {1-9}";
        "super + 0" = "i3-msg workspace number 10";
        "super + shift + 0" = "move container to workspace number 10";
      };
    };
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        focus.followMouse = true;
        gaps = {
          smartBorders = "on";
        };
        modifier = "Mod4";
        keybindings = let
          mainMod = config.xsession.windowManager.i3.config.modifier;
        in {
          "${mainMod} + Left" = "focus left";
          "${mainMod} + Right" = "focus right";
          "${mainMod} + Up" = "focus up";
          "${mainMod} + Down" = "focus down";

          "${mainMod} + Shift + Left" = "move left";
          "${mainMod} + Shift + Right" = "move right";
          "${mainMod} + Shift + Up" = "move up";
          "${mainMod} + Shift + Down" = "move down";

          "${mainMod} + h" = "split h";
          "${mainMod} + v" = "split v";

          "${mainMod} + space" = "fullscreen toggle";
          "${mainMod} + Shift + r" = "restart";
          "${mainMod} + Shift + q" = "restart";
        };
        modes = mkForce {};
        bars = mkForce [];
      };
    };
    randomscanian.desktop = {
      notficiations = enabled;
    };
  };
}
