{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.hardware.storage;
in
{
  options.randomscanian.hardware.storage = with types; {
    enable = mkBoolOpt false "";
  };

  config = mkIf cfg.enable {
  };
}