{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.gui-apps.dolphin;
in
{
  options.randomscanian.gui-apps.dolphin = with types; {
    enable = mkBoolOpt false "Whether or not to dolphin (Emulator).";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      dolphin-emu
    ];
  };
}
