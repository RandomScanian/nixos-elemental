{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.suites.emulation;
in
{
  options.randomscanian.suites.emulation = with types; {
    enable = mkBoolOpt false "Whether or not to enable the emulation suite.";
  };

  config = mkIf cfg.enable {
    randomscanian = {
      gui-apps = {
        yuzu = enabled;
        pcsx2 = enabled;
        citra = enabled;
        dolphin = enabled;
      };
    };
  };
}
