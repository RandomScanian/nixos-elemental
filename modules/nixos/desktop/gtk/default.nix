{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.desktop.gtk;
in {
  options.randomscanian.desktop.gtk = with types; {
    enable = mkBoolOpt false "Whether to customize GTK and apply themes.";
    theme = {
      name = mkOpt str "Dracula" "The name of the GTK theme to apply.";
      pkg = mkOpt package pkgs.dracula-theme "The package to use for the theme.";
    };
    cursor = {
      name = mkOpt str "volantes_cursors" "The name of the cursor theme to apply.";
      pkg = mkOpt package pkgs.volantes-cursors "The package to use for the cursor theme.";
    };
    icon = {
      name = mkOpt str "Papirus" "The name of the icon theme to apply.";
      pkg = mkOpt package pkgs.papirus-icon-theme "The package to use for the icon theme.";
    };
  };

  config = mkIf cfg.enable {
    programs.dconf = {
      enable = true;
    };

    environment.systemPackages = [
      cfg.icon.pkg
      cfg.cursor.pkg
    ];

    environment.sessionVariables = {
      XCURSOR_THEME = cfg.cursor.name;
    };

    randomscanian.system.home.extraOptions = {
      home.pointerCursor = {
        name = cfg.cursor.name;
        package = cfg.cursor.pkg;
        gtk.enable = true;
      };
      gtk = {
        enable = true;

        theme = {
          name = cfg.theme.name;
          package = cfg.theme.pkg;
        };

        cursorTheme = {
          name = cfg.cursor.name;
          package = cfg.cursor.pkg;
        };

        iconTheme = {
          name = cfg.icon.name;
          package = cfg.icon.pkg;
        };
      };
    };
  };
}
