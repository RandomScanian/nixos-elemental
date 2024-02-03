{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.suites.gaming;
in
{
  options.randomscanian.suites.gaming = with types; {
    enable = mkBoolOpt false "";
  };

  config = mkIf cfg.enable {
  };
}