{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.cli-apps.tmux;
in {
  options.randomscanian.cli-apps.tmux = with types; {
    enable = mkBoolOpt false "Whether or not to enable tmux.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [tmux];
    randomscanian.system.home.extraOptions = {
      randomscanian.cli-apps.tmux = enabled;
    };
  };
}
