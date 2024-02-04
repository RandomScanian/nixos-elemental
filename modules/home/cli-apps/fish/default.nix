{lib, config, pkgs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.cli-apps.fish;
in {
  options.randomscanian.cli-apps.fish = {
    enable = mkEnableOption "Whether or not to enable custom Fish config";
    neofetchOnInit = mkBoolOpt true "Whether or not to run neofetch on shell init.";
    enableGrc = mkBoolOpt true "Whether or not to enable grc.";
    enableBangBang = mkBoolOpt true "Whether or not to enable grc.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; mkIf cfg.enableGrc [
      grc
    ];
    programs.fish = {
      enable = true;
      shellInit = ''
        function fish_greeting
        end
      '';
      interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '' + (if cfg.neofetchOnInit == true then "${pkgs.neofetch}/bin/neofetch" else "");
      plugins = [
        (if cfg.enableBangBang == true then {
          name = "bang-bang";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-bang-bang";
            rev = "816c66df34e1cb94a476fa6418d46206ef84e8d3";
            hash = "sha256-35xXBWCciXl4jJrFUUN5NhnHdzk6+gAxetPxXCv4pDc=";
          };
        } else {})
        (if cfg.enableGrc == true then {
          name = "grc";
          src = pkgs.fetchFromGitHub {
            owner = "oh-my-fish";
            repo = "plugin-grc";
            rev = "61de7a8a0d7bda3234f8703d6e07c671992eb079";
            hash = "sha256-NQa12L0zlEz2EJjMDhWUhw5cz/zcFokjuCK5ZofTn+Q=";
          };
        } else {})
      ];
    };
  };
}
