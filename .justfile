set positional-arguments
set allow-duplicate-recipes
set shell := ["bash", "-uc"]

check:
	NIXPKGS_ALLOW_UNFREE=1 nix flake check --impure

rebuild hostname=`hostname`:
	sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch --flake ~/nixos-elemental#$1 --impure
build hostname=`hostname`:
	sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild build --flake ~/nixos-elemental#$1 --impure

rebuild hostname=`hostname`:
	sudo nixos-rebuild switch --flake ~/nixos-elemental#$1
build hostname=`hostname`:
	sudo nixos-rebuild build --flake ~/nixos-elemental#$1