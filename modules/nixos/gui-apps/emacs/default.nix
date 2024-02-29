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
  cfg = config.randomscanian.gui-apps.emacs;
in {
  options.randomscanian.gui-apps.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable emacs.";
  };

  config = mkIf cfg.enable {
    home-manager.users.root = {
      programs.emacs = {
        enable = true;
        extraConfig = builtins.readFile "${inputs.nixos-elemental}/assets/emacs/init.el";
      };
    };
    randomscanian.system.home.extraOptions = {
      randomscanian.gui-apps.emacs = enabled;
    };
  };
}
