{ lib
, buildNpmPackage
, src
, version
, npmDepsHash
, ... }:

buildNpmPackage {
	pname = "filesystem-livesync";
	inherit src version npmDepsHash;
}
