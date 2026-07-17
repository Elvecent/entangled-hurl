{
  description = "Literate API docs with Entangled + Hurl";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    
    entangled = {
      url = "github:entangled/entangled.py";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.brei_flake = {
        url = "github:entangled/brei";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      inputs.repl-session_flake = {
        url = "github:entangled/repl-session";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = { pkgs, inputs', ... }:
      let
        entangledPatched = inputs'.entangled.packages.default.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            substituteInPlace entangled/interface/document.py \
              --replace-fail \
                '                self.load_source(t, p)' \
                '                self.context |= self.load_source(t, p)'
          '';
        });
      in
        {
          devShells.default = pkgs.mkShell {
            name = "entangled-hurl";

            packages = [
              entangledPatched
              pkgs.hurl
              pkgs.pandoc
              pkgs.just
            ];
          };
        };
    };
}
