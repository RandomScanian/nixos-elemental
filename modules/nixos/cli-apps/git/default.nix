{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.cli-apps.git;
in
{
  options.randomscanian.cli-apps.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
    ];
    randomscanian.system.home.extraOptions = {
      randomscanian.cli-apps.git = {
        enable = true;
      };
    };
  };
}
