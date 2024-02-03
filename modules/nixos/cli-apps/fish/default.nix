{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.cli-apps.fish;
in
{
  options.randomscanian.cli-apps.fish = with types; {
    enable = mkBoolOpt false "";
  };

  config = mkIf cfg.enable {
  };
}