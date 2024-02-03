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
    sops = {
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
    
    #Self
    nixos-elemental = {
      url = "github:RandomScanian/nixos-elemental";
      flake = false;
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "randomscanian";
          title = "RandomScanian";
        };

        namespace = "randomscanian";
      };
    };
  in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
      };

      overlays = with inputs; [];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nix-ld.nixosModules.nix-ld
        {
          environment.etc."dracula-rofi".source = "${inputs.dracula-rofi}";
        }
      ];
    };
}
