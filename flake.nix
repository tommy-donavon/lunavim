{
  description = "lunavim";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mnw.url = "github:gerg-l/mnw";
    blink.url = "github:Saghen/blink.cmp";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system:
          let
            pkgs = import nixpkgs {
              inherit system;
            };
          in
          f {
            inherit pkgs system;
          }
        );
    in
    {
      formatter = forEachSupportedSystem ({ pkgs, ... }: pkgs.nixfmt-rfc-style);
      devShells = forEachSupportedSystem (
        { pkgs, system, ... }:
        {
          default = pkgs.mkShell {
            name = "luna-dev";
            packages = with pkgs; [
              nil
              self.formatter.${system}

              cocogitto
              just
              npins
              tokei

              lua
              lua-language-server
              lua53Packages.luacheck
              stylua
            ];

            shellHook = ''
              cog install-hook --all -o
            '';
          };
        }
      );
      packages = forEachSupportedSystem (
        { pkgs, system, ... }:
        rec {
          dev = default.devMode;
          default = inputs.mnw.lib.wrap { inherit system pkgs inputs; } ./config.nix;
        }
      );
      overlays = {
        default = final: prev: {
          lunavim = self.packages.${prev.system}.default;
        };
      };
    };
}
