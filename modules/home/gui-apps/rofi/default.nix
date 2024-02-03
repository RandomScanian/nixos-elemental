{lib, config, pkgs, inputs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.gui-apps.rofi;
in {
  options.randomscanian.gui-apps.rofi = {
    enable = mkEnableOption "Whether or not to enable custom rofi config";
  };

  config = mkIf cfg.enable {
    xdg.configFile."rofi/theme.rasi".source = "${inputs.dracula-rofi}";
    programs.rofi = {
      enable = true;
      cycle = true;
      font = "JetBrainsMono Nerd Font";
    };
  };
}
