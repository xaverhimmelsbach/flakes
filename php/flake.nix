{
  description = "PHP development flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { 
        config.allowUnfree = true;
        inherit system;
      };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs;[
            # PHP dependencies
            php81
            php81Packages.composer

            # Dev dependencies
            nodePackages.intelephense
          ];
        };
      });
}
