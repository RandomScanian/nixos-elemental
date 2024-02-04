{lib, config, pkgs, inputs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.services.polybar;
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
      settings = {
        "bar/top" = {
          monitor = "\${env:MONITOR:DP-0}";
          width = "100%";
          height = "2%";
          font-0 = "JetBrainsMono Nerd Font:pixelsize=10;0";
          radius = 0;
          modules-left = "";
          modules-center = "date";
          modules-right = "";
        };
        "module/date" = {
          type = "internal/date";
          internal = 0;
          date = "%Y/[%b:%m]/[%W]/[%a:%e:%u]";
          time = "%T";
          label = "%date%  %time%";
        };
      };
      script = "polybar top &";
    };
  };
}
