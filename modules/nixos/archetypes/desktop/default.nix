{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.archetypes.desktop;
in {
  options.randomscanian.archetypes.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable the Desktop archetype";
  };

  config = mkIf cfg.enable {
    randomscanian = {
      suites = {
        common = enabled;
        desktop = enabled;
      };
      desktop = {
        lightdm = enabled;
        xmonad = enabled;
        i3 = disabled;
        #sddm = disabled;
      };
      hardware = {
        audio = enabled;
        network = enabled;
        storage = enabled;
      };
      system = {
        kbd = enabled;
        time = enabled;
        locale = enabled;
        fonts = enabled;
      };
    };
  };
}
