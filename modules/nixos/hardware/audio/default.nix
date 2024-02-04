{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.hardware.audio;
in
{
  options.randomscanian.hardware.audio = with types; {
    enable = mkBoolOpt false "Whether or not to enable audio";
  };

  config = mkIf cfg.enable {
    randomscanian.cli-apps.pulsemixer = enabled;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
