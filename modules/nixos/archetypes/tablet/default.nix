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
  cfg = config.randomscanian.archetypes.tablet;
in {
  options.randomscanian.archetypes.tablet = with types; {
    enable = mkBoolOpt false "Whether or not to enable the tablet archetype";
  };

  config = mkIf cfg.enable {
    services.xserver.libinput.enable = true;
    randomscanian = {
      suites = {
        common = enabled;
        desktop = enabled;
      };
      gui-apps.firefox.verticalTabs = false;
      desktop = {
        gdm = enabled;
        gnome = enabled;
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
      services = {
        bluetooth = enabled;
      };
    };
  };
}
