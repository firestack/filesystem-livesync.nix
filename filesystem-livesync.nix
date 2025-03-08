{ lib
, buildNpmPackage
, src
, version
, npmDepsHash
, esbuild
, ... }:

buildNpmPackage {
	pname = "filesystem-livesync";
	inherit src version npmDepsHash;

	npmInstallFlags = [ "-D" ];
}
