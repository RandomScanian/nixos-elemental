{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.suites.gaming;
in
{
  options.randomscanian.suites.gaming = with types; {
    enable = mkBoolOpt false "Whether or not to enable the gaming suite";
  };

  config = mkIf cfg.enable {
    randomscanian = {
    };
  };
}
