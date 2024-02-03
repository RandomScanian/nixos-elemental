{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.suites.desktop;
in
{
  options.randomscanian.suites.desktop = with types; {
    enable = mkBoolOpt false "Whether or not to enable the Desktop suite.";
  };

  config = mkIf cfg.enable {
    randomscanian = {
      gui-apps = {
        alacritty = enabled;
        discord = enabled;
        bitwarden = enabled;
      };
      desktop = {
        gtk = enabled;
        lightdm = enabled;
      };
    };
  };
}
