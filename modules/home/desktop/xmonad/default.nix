{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.xmonad;
  xdotool = "${pkgs.xdotool}/bin/xdotool";
  calc = "${pkgs.calc}/bin/calc";
in {
  options.randomscanian.desktop.xmonad = {
    enable = mkEnableOption "Whether or not to enable custom XMonad config";
  };

  config = mkIf cfg.enable {
    xsession.enable = true;
    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      #config = "${inputs.nixos-elemental}/assets/xmonad/xmonad.hs";
      config = ../../../../assets/xmonad/xmonad.hs;
    };
    randomscanian.desktop.notficiations = enabled;
    randomscanian.desktop.keybindings.extraKeybindings = {
      "super + {0-9}" = "${xdotool} set_desktop $(${calc} {0-9}-1)";
      "super + shift + {0-9}" = "${xdotool} getactivewindow set_desktop_for_window $(${calc} {0-9}-1)";
    };
  };
}
