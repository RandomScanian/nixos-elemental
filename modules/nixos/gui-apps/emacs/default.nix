{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.emacs;
in
{
  options.randomscanian.gui-apps.emacs = with types; {
    enable = mkBoolOpt false "";
  };

  config = mkIf cfg.enable {
  };
}