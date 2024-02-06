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
      url = "github:dracula/alacritty";
      flake = false;
    };
    dracula-rofi = {
      url = "github:dracula/rofi";
      flake = false;
    };

    #DistroTube Xmonad
    distrotube = {
      url = "gitlab:dwt1/dotfiles";
      flake = false;
    };

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
      
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
      };

      overlays = with inputs; [
        nur.overlay
      ];
      
      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [
        inputs.nix-ld.nixosModules.nix-ld
	      inputs.sops-nix.nixosModules.sops
	      "${inputs.nixos-elemental}/secrets/secrets.nix"
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.sharedModules = [
            inputs.nur.hmModules.nur
            inputs.nix-colors.homeManagerModules.default
          ];
        }
      ];
    };
}
