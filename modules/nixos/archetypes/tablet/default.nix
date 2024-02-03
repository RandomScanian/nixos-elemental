{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.archetypes.tablet;
in
{
  options.randomscanian.archetypes.tablet = with types; {
    enable = mkBoolOpt false "";
  };

  config = mkIf cfg.enable {
  };
}