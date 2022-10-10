{
  description = "samyules' great neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # TODO research how nix-direnv is provideing flake-utils
    nix-direnv.url = "github:hoverbear/nix-direnv/merged";
    nix-direnv.inputs.nixpkgs.follows = "nixpkgs";
    /*
    lx2k-nix.url = "github:hoverbear-consulting/lx2k-nix/flake-bump";
    lx2k-nix.inputs.nixpkgs.follows = "nixpkgs";
    */
  };

  outputs = { self, nixpkgs, nix-direnv }:
    let
      # TODO supportedSystems is not using standard flake-utils syntax. Need to change.
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    in
    {
      overlay = final: prev: {
        neovimConfigured = final.callPackage ./packages/neovim.nix { };
      };

      packages = forAllSystems
        (system:
          let
            pkgs = import nixpkgs {
              inherit system;
              overlays = [ self.overlay ];
              config.allowUnfree = true;
            };
          in
          {
            inherit (pkgs) neovimConfigured;
          });
    };
}
# This requires rnix-lsp to be installed for current user.

# I copied this flake egregiously from github:Hoverbear-Consulting/flake
# also see the article at https://hoverbear.org/blog/configurable-nix-packages/
