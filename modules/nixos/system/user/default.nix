{ options, config, lib, pkgs, inputs, ...}:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.system.user;
in
{
  options.randomscanian.system.user = with types; {
    name = mkOpt str "randomscanian" "The users username";
    email = mkOpt str "randomscanian@protonmail.com" "the email of the user";
    shell = mkOpt (enum [ "fish" "zsh" "bash" ]) "fish" "The shell to use";
    sudo = mkBoolOpt true "Whether or not to allow the user to use sudo";
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      extraGroups = mkIf cfg.sudo [ "wheel" ];
      #TODO: Change when get secrets work
      initialHashedPassword = "$y$j9T$O9r0yOHfNX//PTholNQUo1$T9T1g/swpp8ClwVzub7hb67xQ8h2NwnReQVknUL80zD";
    };
  };
}