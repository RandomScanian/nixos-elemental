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
  cfg = config.randomscanian.services.bluetooth;
in {
  options.randomscanian.services.bluetooth = with types; {
    enable = mkBoolOpt false "Whether or not to enable bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
    hardware.bluetooth.settings.General.Enable = mkIf config.randomscanian.hardware.audio.enable "Source,Sink,Media,Socket";
  };
}
