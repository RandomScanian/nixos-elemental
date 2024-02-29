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
  cfg = config.randomscanian.system.user;
in {
  options.randomscanian.system.user = with types; {
    name = mkOpt str "randomscanian" "The users username.";
    realName = mkOpt str "Elias Ferm" "The users real name.";
    email = mkOpt str "randomscanian@protonmail.com" "The email of the user.";
    shell =
      mkOpt
      (enum [
        "fish"
        "zsh"
        "bash"
      ])
      "fish"
      "The shell to use.";
    #hashedPasswordFile = mkOpt path null "The path to hashed password.";
    sudo = mkBoolOpt true "Whether or not to allow the user to use sudo.";
  };

  config = {
    randomscanian.cli-apps.fish =
      if cfg.shell == "fish"
      then enabled
      else disabled;
    users.users.${cfg.name} = {
      #inherit (cfg) hashedPasswordFile;
      isNormalUser = true;
      extraGroups = mkIf cfg.sudo ["wheel"];

      description = cfg.realName;

      shell =
        if cfg.shell == "fish"
        then pkgs.fish
        else
          (
            if cfg.shell == "zsh"
            then pkgs.zsh
            else pkgs.bash
          );
    };
  };
}
