{config, ...}:
{
  config.programs.firefox = {
    profiles.${config.randomscanian.user.name} = {
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
            definedAliases = [ "@np" ];
          };
          "Startpage" = {
            urls = [
              {
                template = "https://www.startpage.com/do/dsearch?q={searchTerms}";
              }
            ];
            definedAliases = [ "@s" ];
          };
          "ProtonDB" = {
            urls = [
              {
                template = "https://www.protondb.com/search?q={searchTerms}";
              }
            ];
            definedAliases = [ "@p" ];
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
            definedAliases = [ "@no" ];
          };
          "NixOS Wiki" = {
            urls = [
              {
                template = "https://nixos.wiki/index.php?search={searchTerms}";
              }
            ];
            iconUpdateURL = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            updateInterval = 24 * 60 * 60 * 1000;
            definedAliases = [ "@nw" ];
          };
          "Youtube" = {
            urls = [
              {
                template = "https://youtube.com/results?search_query={searchTerms}";
              }
            ];
            definedAliases = [ "@y" ];
          };
          "Google".metaData.alias = "@g";
        };
      };
    };
  };
]
