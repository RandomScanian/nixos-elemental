{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.services.polybar;
  colors = {
    foreground = config.colorScheme.palette.base05;
    background = config.colorScheme.palette.base00;
  };
in {
  options.randomscanian.services.polybar = with types; {
    enable = mkEnableOption "Whether or not to enable polybar.";
  };

  config = mkIf cfg.enable {
    services.polybar = {
      enable = true;

      package = pkgs.polybar.override {
        alsaSupport = true;
        githubSupport = true;
        iwSupport = true;
      };
      settings = mkIf false {
        "bar/top" = {
          monitor = "\${env:MONITOR:DP-0}";
          width = "100%";
          height = "2%";
          font-0 = "JetBrainsMono Nerd Font:pixelsize=10;antialias=true;0";
          radius = 0;
          modules-left = "ewmh";
          modules-center = "date";
          modules-right = "";
        };

        "module/ewmh" = {
          type = "internal/xworkspaces";

          pin-workspaces = true;
          enable-click = false;
          enable-scroll = false;

          label-active = "%name%";
          label-active-foreground = "${colors.foreground}";
          label-active-background = "${colors.background}";
          label-active-padding = 1;
          label-active-underline = "${colors.color5}";
          label-active-margin = 2;

          label-occupied = "%name%";
          label-occupied-background = "${colors.background}";
          label-occupied-padding = 1;
          label-occupied-underline = "${colors.color12}";
          label-occupied-margin = 2;

          label-urgent = "%name%";
          label-urgent-foreground = "${colors.foreground}";
          label-urgent-background = "${colors.alert}";
          label-urgent-underline = "${colors.alert}";
          label-urgent-padding = 1;
          label-urgent-margin = 2;

          label-empty = "%name%";
          label-empty-foreground = "${colors.foreground}";
          label-empty-padding = 1;
          label-empty-margin = 2;

          format-foreground = "${colors.foreground}";
          format-background = "${colors.background}";
        };

        "module/date" = {
          type = "internal/date";
          internal = 0;
          date = "%Y/[%b:%m]/[%W]/[%a:%u:%d]";
          time = "%T %Z";
          label = "%date% %time%";
        };
      };
      script = "polybar top -r &";
    };
  };
}
