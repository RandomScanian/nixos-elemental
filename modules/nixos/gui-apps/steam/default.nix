{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.steam;
in
{
  options.randomscanian.gui-apps.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable Steam.";
    openFirewall = mkBoolOpt true "Whether or not to open steam network ports.";
  };

  config = mkIf cfg.enable {
    hardware.steam-hardware = enabled;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = cfg.openFirewall;
      dedicatedServer.openFirewall = cfg.openFirewall;
    };
  };
}
