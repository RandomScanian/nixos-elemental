set positional-arguments
set shell := ["bash", "-uc"]

check:
	nix flake check

rebuild hostname=`hostname`:
	sudo nixos-rebuild switch --flake ~/nixos-elemental#$1
build hostname=`hostname`:
	sudo nixos-rebuild build --flake ~/nixos-elemental#$1