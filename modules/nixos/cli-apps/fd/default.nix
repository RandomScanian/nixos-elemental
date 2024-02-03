{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.cli-apps.fd;
in
{
  options.randomscanian.cli-apps.fd = with types; {
    enable = mkBoolOpt false "Whether or not to enable fd.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fd
    ];
  };
}
