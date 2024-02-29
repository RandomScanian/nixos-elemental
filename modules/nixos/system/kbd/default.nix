{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.system.kbd;
in {
  options.randomscanian.system.kbd = with types; {
    enable = mkBoolOpt false "Whether or not to configure keyboard.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "colemak";
      xkb.options = "eurosign:e";
    };
  };
}
