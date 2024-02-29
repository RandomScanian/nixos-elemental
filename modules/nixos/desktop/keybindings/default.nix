{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.keybindings;
in {
  options.randomscanian.desktop.keybindings = with types; {
    enable = mkBoolOpt false "Whether or not to enable keybindings.";
  };

  config = mkIf cfg.enable {
    randomscanian.system.home.extraOptions = {
      randomscanian.desktop.keybindings = enabled;
    };
  };
}
