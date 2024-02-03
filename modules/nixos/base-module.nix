{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.1.2;
in
{
  options.randomscanian.1.2 = with types; {
    enable = mkBoolOpt false "3";
  };

  config = mkIf cfg.enable {
  };
};
