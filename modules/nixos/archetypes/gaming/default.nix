{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.archetypes.gaming;
in
{
  options.randomscanian.archetypes.gaming = with types; {
    enable = mkBoolOpt false "Whether or not to enable the Gaming archetype.";
    emulation = mkBoolOpt true "Whether or not to enable emulation.";
  };

  config = mkIf cfg.enable {
    randomscanian = {
      suites = {
        emulation = enabled;
        gaming = enabled;
      };
      gui-apps = {
        steam = enabled;
    };
  };
}
