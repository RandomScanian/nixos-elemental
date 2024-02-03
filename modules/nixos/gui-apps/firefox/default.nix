{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.firefox;
in
{
  options.randomscanian.gui-apps.firefox = with types; {
    enable = mkBoolOpt false "";
  };

  config = mkIf cfg.enable {
  };
}