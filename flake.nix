{
  description = "lunavim";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    blink.url = "github:Saghen/blink.cmp";
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";
    mnw.url = "github:gerg-l/mnw";
    systems.url = "github:nix-systems/default";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      systems,
      ...
    }:
    let
      eachSystem =
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system:
          let
            pkgs = import nixpkgs {
              inherit system;
            };
          in
          f { inherit pkgs system; }
        );
      treefmtEval = eachSystem (
        { pkgs, ... }:
        inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs = {
            taplo.enable = true;
            just.enable = true;

            deadnix.enable = true;
            statix.enable = true;
            stylua = {
              enable = true;
              settings = {
                indent_width = 2;
                line_endings = "Unix";
                quote_style = "AutoPreferSingle";
                call_parentheses = "NoSingleTable";
                sort_requires.enabled = true;
              };
            };
            nixfmt = {
              enable = true;
              package = pkgs.nixfmt-rfc-style;
            };
          };

        }
      );
    in
    {
      formatter = eachSystem ({ system, ... }: treefmtEval.${system}.config.build.wrapper);
      checks = eachSystem (
        { system, ... }:
        {
          formatting = treefmtEval.${system}.config.build.check self;
        }
      );
      devShells = eachSystem (
        { pkgs, system, ... }:
        {
          default = pkgs.mkShell {
            name = "luna-dev";
            packages = with pkgs; [
              nil

              cocogitto
              just
              npins

              lua
              lua-language-server
              lua53Packages.luacheck
              treefmtEval.${system}.config.build.wrapper
            ];

            shellHook = ''
              cog install-hook --all -o
            '';
          };
        }
      );
      packages = eachSystem (
        { pkgs, system, ... }:
        rec {
          dev = default.devMode;
          default = inputs.mnw.lib.wrap { inherit system pkgs inputs; } ./config.nix;
        }
      );
      overlays = {
        default = _final: prev: {
          lunavim = self.packages.${prev.system}.default;
        };
      };
    };
}
