{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        pname = "shuba-cursors";
        version = "git-${self.shortRev or "dirty"}";
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          inherit pname version;

          src = pkgs.lib.cleanSource self;

          installPhase = ''
            install -dm 755 $out/share/icons/Shuba
            cp -r cursors $out/share/icons/Shuba/cursors
            cp index.theme $out/share/icons/Shuba/index.theme
          '';
        };
      });
}
