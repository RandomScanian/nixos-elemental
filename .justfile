rebuild-hydrogen:
	sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --flake /nixos-elemental#Hydrogen --impure
build-hydrogen:
	sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild build --flake /nixos-elemental#Hydrogen --impure