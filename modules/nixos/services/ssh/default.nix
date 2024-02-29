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
  cfg = config.randomscanian.services.ssh;
in {
  options.randomscanian.services.ssh = with types; {
    enable = mkBoolOpt false "Whether or not to enable sshd";
    passwordLogin = mkBoolOpt false "Whether or not to enable passwordAuthentication.";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      allowSFTP = true;
      settings = {
        PasswordAuthentication = cfg.passwordLogin;
      };
    };
  };
}
