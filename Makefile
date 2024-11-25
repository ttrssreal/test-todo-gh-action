FLAKE_ROOT := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
.PHONY = jess-laptop ari server build-%

build-%:
	sudo nixos-rebuild build --flake "${FLAKE_ROOT}#$*"

%:
	sudo nixos-rebuild switch --flake "${FLAKE_ROOT}#$@"
