{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.gui-apps.emacs;
  restart-emacs-if-not-running = "systemctl --user restart emacs";
in {
  options.randomscanian.gui-apps.emacs = {
    enable = mkEnableOption "Whether or not to enable custom emacs config";
  };

  config = mkIf cfg.enable {
    xdg.configFile."chemacs/profiles.el".text = ''
      (
        ("default" . ((user-emacs-directory . "${config.xdg.configHome}/chemacs/default")))
      )'';
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [ epkgs.vterm ];
    };
    services.emacs = {
      enable = true;
      client.enable = true;
      defaultEditor = true;
      socketActivation.enable = false;
    };
    home.packages = with pkgs; [ emacs-all-the-icons-fonts ];
    randomscanian.desktop.keybindings = {
      extraKeybindings = {
        "super + w; super + w" =
          ''emacsclient -c -a "${restart-emacs-if-not-running}"'';
        "super + w; super + c" =
          ''emacsclient -c -a "${restart-emacs-if-not-running}" --eval "(full-calc)"'';
      };
    };
  };
}
