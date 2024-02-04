{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.cli-apps.tldr;
in
{
  options.randomscanian.cli-apps.tldr = with types; {
    enable = mkBoolOpt false "Whether or not to enable tldr.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tldr
    ];
  };
}
