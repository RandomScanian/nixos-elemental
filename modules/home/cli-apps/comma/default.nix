{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.cli-apps.comma;
in {
  options.randomscanian.cli-apps.comma = with types; {
    enable = mkEnableOption "Whether or not to enable comma.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      comma
      randomscanian.nix-update-index
    ];
    programs.nix-index.enable = true;
  };
}
