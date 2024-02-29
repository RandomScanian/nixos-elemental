{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.wallpapers;
  feh = "${pkgs.feh}/bin/feh";
in {
  options.randomscanian.desktop.wallpapers = with types; {
    enable = mkEnableOption "Whether or not to apply custom wallpapers.";
    wallpaper =
      mkOpt str "${inputs.dracula-wallpaper}/first-collection/nixos.png"
      "The wallpaper to use";
  };

  config = mkIf cfg.enable {
    xsession.profileExtra = "${feh} ${cfg.wallpaper} --no-fehbg --bg-scale";
  };
}
