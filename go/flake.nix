{
  description = "Golang development flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell = pkgs.mkShell {
          # Prevent gcc failing on compile
          hardeningDisable = [ "fortify" ];
          buildInputs = with pkgs;[
            # Golang
            go
            # Language server
            gopls
            # Linter
            golangci-lint
            # goimports, callgraph, digraph, stringer, toolstash
            gotools
            # Debugger
            delve
          ];
        };
      });
}
