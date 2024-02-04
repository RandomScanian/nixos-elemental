{lib, config, pkgs, inputs, ...}:
with lib;
with lib.randomscanian;
let
  cfg = config.randomscanian.gui-apps.firefox;
in {
  options.randomscanian.gui-apps.firefox = {
    enable = mkEnableOption "Whether or not to enable custom Firefox config.";
    verticalTabs = mkBoolOpt true "Whether or not to enable vertical tabs.";
    extraConfig = mkOpt str "" "Extra configuration for the user profile JS file.";
    userChrome = mkOpt str "" "Extra configuration for the user chrome CSS file.";
    settings = mkOpt attrs defaultSettings "Settings to apply to the profile.";
  };

  config = mkIf cfg.enable {
    imports = [ ./firefox-search.nix ];
    programs.firefox = {
      enable = true;

      profiles.${config.randomscanian.user.name} = {
        inherit (cfg) extraConfig userChrome settings;
        id = 0;
        name = config.randomscanian.user.name;
        bookmarks = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "wikipedia";
                tags = [ "wiki" ];
                keyword = "wiki";
                url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
              }
              {
                name = "homepage";
                tags = [ "nix" ];
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [ "wiki" "nix" ];
                url = "https://nixos.wiki/";
              }
              {
                name = "youtube";
                tags = [ "no-trust" ];
                url = "https://youtube.com/";
              }
              {
                name = "New Tab";
                tags = [ "home" ];
                url = "about:home";
              }
            ];
          }
        ];
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          sponsorblock
          privacy-badger
          dracula-dark-colorscheme
          darkreader
          sidebery
          tab-counter-plus
          honey
          return-youtube-dislikes
          fastforwardteam
        ];
        settings = {
          "general.smoothScroll" = true;
          "general.autoscroll" = true;
          "browser.tabs.firefox-view" = false;
        };
        extraConfig = ''
             user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
             user_pref("full-screen-api.ignore-widgets", true);
             user_pref("media.ffmpeg.vaapi.enabled", true);
             user_pref("media.rdd-vpx.enabled", true);
             user_pref(browser.sessionstore.max_windows_undo, 20);
            ${builtins.readFile "${inputs.assets}/Betterfox/user.js"}
          '';
        userChrome = ''
            #TabsToolbar{ visibility: collapse !important }
          '';
        userContent = "";
      };
    };
  };
}
