{lib, config, pkgs, inputs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.desktop.xmonad;
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
  };
}
