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
  cfg = config.randomscanian.gui-apps.discord;
  discordPackage = lib.replugged.makeDiscordPlugged {
    inherit pkgs;
    withOpenAsar = false;
    plugins = {
      inherit (inputs) discord-tweaks;
    };
  };
in {
  options.randomscanian.gui-apps.discord = with types; {
    enable = mkBoolOpt false "Whether or not to enable Discord.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [discordPackage];
    randomscanian.system.home.extraOptions.randomscanian.desktop.keybindings.extraKeybindings = {
      "super + a; super + d" = "discord";
    };
  };
}
