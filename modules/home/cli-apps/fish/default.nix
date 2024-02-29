{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.cli-apps.fish;
in {
  options.randomscanian.cli-apps.fish = {
    enable = mkEnableOption "Whether or not to enable custom Fish config";
    neofetchOnInit = mkBoolOpt true "Whether or not to run neofetch on shell init.";
    enableGrc = mkBoolOpt true "Whether or not to enable grc.";
    enableBangBang = mkBoolOpt true "Whether or not to enable grc.";
    enableZoxide = mkBoolOpt true "Whether or not to enable zoxide.";
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; mkIf cfg.enableGrc [grc];
      shellAliases = optionalAttrs config.randomscanian.gui-apps.emacs.enable {
        cdired = ''emacs --no-window-system --eval "(dired \"$(pwd)\""'';
        dired = ''emacs --eval "(dired \"$(pwd)\""'';
      };
    };

    programs.zoxide = mkIf cfg.enableZoxide {
      enable = true;
      options = [];
    };

    programs.fish = {
      enable = true;
      shellInit = ''
        function fish_greeting
        end'';
      interactiveShellInit =
        ''
          ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
        ''
        + optionalString cfg.neofetchOnInit ''
          ${pkgs.neofetch}/bin/neofetch
        '';
      plugins = [
        (
          if cfg.enableBangBang
          then {
            name = "bang-bang";
            src = inputs.fishBangBang;
          }
          else {}
        )
        (
          if cfg.enableGrc
          then {
            name = "grc";
            src = inputs.fishGrc;
          }
          else {}
        )
      ];
    };
  };
}
