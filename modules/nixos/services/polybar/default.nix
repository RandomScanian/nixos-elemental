{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.services.polybar;
in
{
  options.randomscanian.services.polybar = with types; {
    enable = mkBoolOpt false "Whether or not to enable polybar";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      polybar
    ];
    randomscanian.system.home.extraOptions = {
      randomscanian.services.polybar = enabled;
    };
  };
}
