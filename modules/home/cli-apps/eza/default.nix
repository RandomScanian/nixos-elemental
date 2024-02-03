{lib, config, pkgs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.cli-apps.eza;
in {
  options.randomscanian.cli-apps.eza = {
    enable = mkEnableOption "Whether or not to enable custom Eza config";
    enableAliases = mkBoolOpt true "Whether or not to create aliases for ls";
  };

  config = mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableAliases = true;
    };
  };
}
