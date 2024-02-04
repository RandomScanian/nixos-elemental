{lib, config, pkgs, inputs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.gui-apps.alacritty;
in {
  options.randomscanian.gui-apps.alacritty = {
    enable = mkEnableOption "Whether or not to enable custom alacritty config";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        import = [ "${inputs.dracula-alacritty}/dracula.toml" ];
        window.opacity = 1;
        font = {
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "JetBrainsMono Nerd Font";
            style = "Bold Italic";
          };
          size = 10;
        };
      };
    };
  };
}
