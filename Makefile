FLAKE_ROOT := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

jess-laptop:
	sudo nixos-rebuild switch --flake "${FLAKE_ROOT}#$@"
