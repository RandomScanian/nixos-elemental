{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.yuzu;
in
{
  options.randomscanian.gui-apps.yuzu = with types; {
    enable = mkBoolOpt false "Whether or not to enable yuzu.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      yuzuPackages.early-access
    ];
  };
}
