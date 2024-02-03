{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.discord;
in
{
  options.randomscanian.gui-apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      discord
    ];
  };
}
