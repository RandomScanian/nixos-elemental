{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.citra;
in
{
  options.randomscanian.gui-apps.citra = with types; {
    enable = mkBoolOpt false "Whether or not to enable citra.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      citra
    ];
  };
}
