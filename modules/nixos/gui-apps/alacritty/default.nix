{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.alacritty;
in
{
  options.randomscanian.gui-apps.alacritty = with types; {
    enable = mkBoolOpt false "Whether or not to enable Alacritty";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty
    ];
    randomscanian.system.home.extraOptions = {
      randomscanian.gui-apps.alacritty = enabled;
    };
  };
}
