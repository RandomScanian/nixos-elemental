{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.randomscanian; let
  cfg = config.randomscanian.gui-apps.firefox;
in {
  options.randomscanian.gui-apps.firefox = with types; {
    enable = mkEnableOption "Whether or not to enable custom Firefox config.";
    verticalTabs = mkBoolOpt true "Whether or not to enable vertical tabs.";
    extraConfig = mkOpt str "" "Extra configuration for the user profile JS file.";
    userChrome = mkOpt str "" "Extra configuration for the user chrome CSS file.";
    settings = mkOpt attrs {} "Settings to apply to the profile.";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.${config.home.username} = {
        id = 0;
        name = config.home.username;

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
          youtube-shorts-block
        ];

        extraConfig =
          ''
             user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
             user_pref("full-screen-api.ignore-widgets", true);
             user_pref("media.ffmpeg.vaapi.enabled", true);
             user_pref("media.rdd-vpx.enabled", true);
             user_pref(browser.sessionstore.max_windows_undo, 20);

             ${builtins.readFile "${inputs.betterfox}/user.js"}

             //// Common overrides

             // PREF: enable container tabs
             user_pref("privacy.userContext.enabled", true);

             //// Optional hardening

             // PREF: disable Firefox View
             user_pref("browser.tabs.firefox-view", false);
             user_pref("browser.tabs.firefox-view-next", false); // [FF119+]
             user_pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");n

             // PREF: disable Firefox Sync
             user_pref("identity.fxaccounts.enabled", false);

             // Fastfox.js
            user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
            user_pref("general.smoothScroll", true); // DEFAULT
            user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
            user_pref("general.smoothScroll.msdPhysics.enabled", true);
            user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
            user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
            user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
             user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", 2.0);
            user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
            user_pref("general.smoothScroll.currentVelocityWeighting", 1.0);
            user_pref("general.smoothScroll.stopDecelerationWeighting", 1.0);
            user_pref("mousewheel.default.delta_multiplier_y", 300);

             user_pref(browser.sessionstore.resume_from_crash, false);
             user_pref(browser.sessionstore.max_resumed_crashes, 0);
          ''
          + cfg.extraConfig;

        settings =
          {
            "general.smoothScroll" = true;
            "general.autoscroll" = true;
            "browser.tabs.firefox-view" = false;
          }
          // cfg.settings;

        userChrome =
          ''
            #TabsToolbar{ visibility: collapse !important }
          ''
          + cfg.userChrome;

        #userContent = "";

        bookmarks = [
          {
            name = "Nix sites";
            toolbar = true;
            bookmarks = [
              {
                name = "wikipedia";
                tags = ["wiki"];
                keyword = "wiki";
                url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
              }
              {
                name = "homepage";
                tags = ["nix"];
                url = "https://nixos.org/";
              }
              {
                name = "wiki";
                tags = [
                  "wiki"
                  "nix"
                ];
                url = "https://nixos.wiki/";
              }
              {
                name = "youtube";
                tags = ["no-trust"];
                url = "https://youtube.com/";
              }
              {
                name = "New Tab";
                tags = ["home"];
                url = "about:home";
              }
            ];
          }
        ];

        search = {
          force = true;
          default = "Startpage";
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };

            "Startpage" = {
              urls = [{template = "https://www.startpage.com/do/dsearch?q={searchTerms}";}];
              definedAliases = ["@s"];
            };

            "ProtonDB" = {
              urls = [{template = "https://www.protondb.com/search?q={searchTerms}";}];
              definedAliases = ["@p"];
            };

            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@no"];
            };

            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = ["@nw"];
            };

            "Youtube" = {
              urls = [{template = "https://youtube.com/results?search_query={searchTerms}";}];
              definedAliases = ["@y"];
            };

            "Google".metaData.alias = "@g";
          };
        };
      };
    };
  };
}
