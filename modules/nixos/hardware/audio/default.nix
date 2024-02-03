{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.hardware.audio;
in
{
  options.randomscanian.hardware.audio = with types; {
    enable = mkBoolOpt false "";
  };

  config = mkIf cfg.enable {
  };
}