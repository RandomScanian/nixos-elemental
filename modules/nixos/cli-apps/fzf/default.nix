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
  cfg = config.randomscanian.cli-apps.fzf;
in {
  options.randomscanian.cli-apps.fzf = with types; {
    enable = mkBoolOpt false "Whether or not to enable fzf";
  };

  config = mkIf cfg.enable {environment.systemPackages = with pkgs; [fzf];};
}
