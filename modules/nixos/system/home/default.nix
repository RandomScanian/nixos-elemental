{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.randomscanian;
let cfg = config.randomscanian.home;
in
{
  options.randomscanian.system.home = with types; {
    file = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    randomscanian.system.home.extraOptions = {
      programs.home-manager = enabled;
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.randomscanian.system.home.file;
      xdg.enable = true;
      xdg.userDirs.createDirectories = true;
      xdg.configFile = mkAliasDefinitions options.randomscanian.system.home.configFile;
      home.username = "${config.randomscanian.system.user.name}";
      home.homeDirectory = "/home/${config.randomscanian.system.user.name}";
    };

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.root = {
        home.stateVersion = config.system.stateVersion;
      	xdg.enable = true;
      	xdg.userDirs.createDirectories = true;
	programs.home-manager = enabled;
      };
      
      users.${config.randomscanian.system.user.name} =
        mkAliasDefinitions options.randomscanian.system.home.extraOptions;
    };
  };
}
