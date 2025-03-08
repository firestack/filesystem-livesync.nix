{
	description = "Description for the project";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		# nixpkgs.follows = "nixpkgs";
		flake-parts.inputs.nixpkgs-lib.follows = "/nixpkgs";
		filesystem-livesync-source.follows = "/self?submodules=1";
	};

	outputs = inputs@{ flake-parts, filesystem-livesync-source, ... }:
		flake-parts.lib.mkFlake { inherit inputs; } {
			imports = [
				# To import a flake module
				# 1. Add foo to inputs
				# 2. Add foo as a parameter to the outputs function
				# 3. Add here: foo.flakeModule

			];
			systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
			perSystem = { config, self', inputs', pkgs, lib, system, ... }: {
				# Per-system attributes can be defined here. The self' and inputs'
				# module parameters provide easy access to attributes of the same
				# system.

				# Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
				packages.default = self'.packages.filesystem-livesync;
				packages.filesystem-livesync = pkgs.callPackage ./filesystem-livesync.nix {
					src = lib.cleanSource filesystem-livesync-source.outPath;
					# version = filesystem-livesync-source.
					version = "0.0.1";
					# npmDepsHash = "sha256-6PO3gbAwNH8xOUuP9D9YZ2BLtdV5mlmkxt/981+f4K0=";
					# npmDepsHash = lib.fakeHash;
					npmDepsHash = "sha256-SZb9cPe5a58DNKBR+fxknqmmslccV+nKDWMnSaCJhOw=";
				};
			};
			flake = {
				# The usual flake attributes can be defined here, including system-
				# agnostic ones like nixosModule and system-enumerating ones, although
				# those are more easily expressed in perSystem.

			};
		};
}
