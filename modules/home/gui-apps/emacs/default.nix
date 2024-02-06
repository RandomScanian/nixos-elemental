{lib, config, pkgs, inputs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.gui-apps.emacs;
in {
  options.randomscanian.gui-apps.emacs = {
    enable = mkEnableOption "Whether or not to enable custom emacs config";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
    };
  };
}
