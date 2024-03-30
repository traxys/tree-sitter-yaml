{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShell = with pkgs;
        mkShell {
          nativeBuildInputs = [pkgs.bashInteractive];
          buildInputs = [
            pkgs.nodejs-slim
            (pkgs.rustPlatform.buildRustPackage rec {
              pname = "tree-sitter";
              version = "0.21.0";

              src = pkgs.fetchFromGitHub {
                owner = "tree-sitter";
                repo = "tree-sitter";
                rev = "v${version}";
                hash = "sha256-reW4R3s5uwsdjxzxt313Wii1gXUIFyJ9AECvpBXI37c=";
              };

              doCheck = false;

              cargoHash = "sha256-/ydaZMJ93xua17oRKfqieAd2VXq8q+4LGYSKJkTJ9T0=";
            })
          ];
        };
    });
}
