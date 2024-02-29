{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.system.locale;
in {
  options.randomscanian.system.locale = with types; {
    enable = mkBoolOpt false "Whether or not to manage locale settings.";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LANG = "en_US.UTF-8";
      LANGUAGE = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
      LC_COLLATE = "en_US.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
    };
    console = {
      keyMap = mkForce "colemak";
      font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    };
  };
}
