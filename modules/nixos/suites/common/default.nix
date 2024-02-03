{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.suites.common;
in
{
  options.randomscanian.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable the common suite";
  };

  config = mkIf cfg.enable {
    randomscanian = {
      cli-apps = {
        tmux = enabled;
        fd = enabled;
        fzf = enabled;
        ripgrep = enabled;
        eza = enabled;
      };
    };
  };
}
