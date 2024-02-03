{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.hardware.network;
in
{
  options.randomscanian.hardware.network = with types; {
    enable = mkBoolOpt false "Whether or not to enable networking.";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.resolvconf.dnsExtensionMechanism = false;
  };
}
