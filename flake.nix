{
	description = "Description for the project";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

		filesystem-livesync-source.follows = "/";
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
			perSystem = { config, self', inputs', pkgs, system, ... }: {
				# Per-system attributes can be defined here. The self' and inputs'
				# module parameters provide easy access to attributes of the same
				# system.

				# Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
				packages.default = self'.packages.filesystem-livesync;
				packages.filesystem-livesync = pkgs.callPackage ./filesystem-livesync.nix {
					src = filesystem-livesync-source.outPath;
					version = "0.0.1";
					npmDepsHash = "sha256-6PO3gbAwNH8xOUuP9D9YZ2BLtdV5mlmkxt/981+f4K0=";
				};
			};
			flake = {
				# The usual flake attributes can be defined here, including system-
				# agnostic ones like nixosModule and system-enumerating ones, although
				# those are more easily expressed in perSystem.

			};
		};
}
