{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let 
    supportedSystems = [ "x86_64-linux" ];
    forAllSystems = pkgsRaw: evaluation: (nixpkgs.lib.genAttrs supportedSystems) (system:  evaluation system pkgsRaw.${system});
    src = ./.;
  in {
    apps = forAllSystems nixpkgs.legacyPackages (system: pkgs: rec {
        default = linkscript;
        linkscript = {
          type = "app";
          program = "${src}/link.sh";
        };
        });
  };
}
