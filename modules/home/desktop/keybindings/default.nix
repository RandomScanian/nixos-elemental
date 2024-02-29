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
  xdotool = "${pkgs.xdotool}/bin/xdotool";
  calc = "${pkgs.calc}/bin/calc";
  notify-send = "${pkgs.libnotify}/bin/notify-send";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
in {
  options.randomscanian.desktop.keybindings = with types; {
    enable = mkEnableOption "Whether or not to enable keybindings";
    enableDefaultKeybindings = mkBoolOpt true "Whether or not to enable default keybindings.";
    extraKeybindings = mkOpt attrs {} "The keybindings to use.";
    terminal = mkOpt str "alacritty" "The terminal to use.";
    editor = mkOpt str "emacs" "The editor to use.";
    browser = mkOpt str "firefox" "The browser to use.";
  };

  config = mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings =
        {
          "super + shift + x" = "pkill -usr1 -x sxhkd; ${notify-send} 'sxhkd' 'Reloaded config'";
        }
        // cfg.extraKeybindings
        // optionalAttrs cfg.enableDefaultKeybindings {
          "super + shift + x" = "pkill -usr1 -x sxhkd; ${notify-send} 'sxhkd' 'Reloaded config'";
          "super + shift + Return" = "${cfg.terminal}";

          "super + a; b" = "${cfg.browser}";
          "super + a; super + b" = "${cfg.browser}";

          "XF86AudioRaiseVolume" = "${pamixer} -i 1";
          "XF86AudioLowerVolume" = "${pamixer} -d 1";
          "XF86AudioMute" = "${pamixer} -t";

          "super + shift + c" = "${xdotool} getactivewindow windowquit";
          "super + control + c" = "${pkgs.xorg.xkill}/bin/xkill";
        };
    };
  };
}
