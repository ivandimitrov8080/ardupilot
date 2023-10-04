{
  description = "NextJS Template";

  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        buildInputs = with pkgs; [
          python311Packages.empy
          python311Packages.pexpect
          python311Packages.future
          python311Packages.setuptools
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          inherit buildInputs;
        };
      });
}


