{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.cli-apps.ripgrep;
in
{
  options.randomscanian.cli-apps.ripgrep = with types; {
    enable = mkBoolOpt false "Whether or not to enable ripgrep.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ripgrep
    ];
  };
}
