{lib, config, pkgs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.cli-apps.git;
in {
  options.randomscanian.cli-apps.git = with types; {
    enable = mkEnableOption "Whether or not to enable git.";
    username = mkOpt str "RandomScanian" "The username for git to use";
    usermail = mkOpt str "randomscanian@protonmail.com" "the email for git to use";
    signing = mkBoolOpt false "Whether or not to enable signing.";
    key = mkOpt str "" "The key to use if singing.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.username;
      userEmail = cfg.usermail;
      lfs = {
        enable = true;
      };
      signing = mkIf cfg.signing {
        enable = true;
	key = cfg.key;
	signByDefault = true;
      };
    };
  };
}
