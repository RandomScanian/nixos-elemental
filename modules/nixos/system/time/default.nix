{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.system.time;
in {
  options.randomscanian.system.time = with types; {
    enable = mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable {time.timeZone = "Europe/Stockholm";};
}
