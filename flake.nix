{
  description = "My NixOS / nix-darwin / nixos-generators systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-checker = {
      url = "github:DeterminateSystems/flake-checker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Discord Replugged
    replugged.url = "github:LunNova/replugged-nix-flake";
    replugged.inputs.nixpkgs.follows = "nixpkgs";

    # Discord Replugged plugins / themes
    discord-tweaks = {
      url = "github:NurMarvin/discord-tweaks";
      flake = false;
    };

    #TODO: setup secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Dracula theming
    dracula-alacritty = {
      url = "github:dracula/alacritty/9ae0fdedd423803f0401f6e7a23cd2bb88c175b2";
      flake = false;
    };
    dracula-wallpaper = {
      url = "github:dracula/wallpaper/f2b8cc4223bcc2dfd5f165ab80f701bbb84e3303";
      flake = false;
    };
    dracula-rofi = {
      url = "github:dracula/rofi/459eee340059684bf429a5eb51f8e1cc4998eb74";
      flake = false;
    };
    dracula-sddm = {
      url = "github:nopain1210/Yet-another-dracula/69bb62e94654cecde4278816559d5dd75e9b5141?dir=Yet-another-dracula/sddm/Dracula/";
      flake = false;
    };

    # Fish plugins
    fishBangBang = {
      url = "github:oh-my-fish/plugin-bang-bang";
      flake = false;
    };
    fishGrc = {
      url = "github:oh-my-fish/plugin-grc";
      flake = false;
    };

    #Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    
    #Betterfox
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };

    #Colors
    nix-colors.url = "github:misterio77/nix-colors";

    #Comma
    comma = {
      url = "github:nix-community/comma";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Nur
    nur.url = "github:nix-community/NUR";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Database of nixpkgs
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Self
    nixos-elemental = {
      url = "github:RandomScanian/nixos-elemental";
      flake = false;
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      # Configure Snowfall Lib, all of these settings are optional.
      snowfall = {
        # Choose a namespace to use for your flake's packages, library,
        # and overlays.
        namespace = "randomscanian";

        # Add flake metadata that can be processed by tools like Snowfall Frost.
        meta = {
          # A slug to use in documentation when displaying things like file paths.
          name = "nixos-elemental";

          # A title to show for your flake, typically the name.
          title = "nixos-elemental";
        };
      };

      outputs-builder = channels: {formatter = channels.nixpkgs.alejandra;};

      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
      };

      overlays = with inputs; [nur.overlay];

      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [

        {
          nix.settings = {
            auto-optimise-store = true;
          };
          #nix.extraOptions = ''access-tokens = github.com=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'';
          environment.etc."sddm-theme".source = inputs.dracula-sddm;
        }
        
        inputs.nix-ld.nixosModules.nix-ld
        inputs.sops-nix.nixosModules.sops
        "${inputs.nixos-elemental}/secrets/secrets.nix"
        inputs.nix-index-database.nixosModules.nix-index
        {
          programs.nix-index.enableBashIntegration = false;
          programs.nix-index.enableZshIntegration = false;
          programs.nix-index.enableFishIntegration = true;
          programs.nix-index-database.comma.enable = true;
        }
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = [
            inputs.nur.hmModules.nur
            inputs.nix-colors.homeManagerModules.default
            inputs.nix-index-database.hmModules.nix-index
            {programs.nix-index-database.comma.enable = true;}
          ];
        }
      ];
    };
}
