{
  description = "lunavim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    mnw.url = "github:gerg-l/mnw";
    blink.url = "github:Saghen/blink.cmp";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }@inputs:
    let
      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs (import systems) (
          system:
          f {
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                #            inputs.neovim-nightly-overlay.overlays.default
              ];
            };
          }
        );
    in
    {
      formatter = forEachSupportedSystem ({ pkgs }: pkgs.nixfmt-rfc-style);
      devShells = forEachSupportedSystem (
        { pkgs }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nil
              self.formatter.${pkgs.stdenv.hostPlatform.system}
              self.packages.${pkgs.stdenv.hostPlatform.system}.yue
              just
              tokei
              cocogitto
              npins
              lua
            ];

            shellHook = ''
              cog install-hook --all -o
            '';
          };
        }
      );
      packages = forEachSupportedSystem (
        { pkgs }:
        rec {
          yue = pkgs.callPackage ./packages/yuescript.nix { };
          lunavim = pkgs.callPackage ./packages/lunavim.nix {
            inherit yue;
            version = builtins.substring 0 8 self.lastModifiedDate;
          };
          default =
            # based on https://github.com/Gerg-L/nvim-flake/blob/master/flake.nix#L100
            inputs.mnw.lib.wrap pkgs {
              neovim = pkgs.neovim-unwrapped;

              appName = "lunavim";

              extraLuaPackages = p: [ p.luafilesystem ];

              initLua = ''
                require('lunavim')
              '';

              desktopEntry = false;

              plugins =
                with pkgs.vimPlugins;
                [
                  lunavim
                  nvim-treesitter.withAllGrammars
                  plenary-nvim
                  snacks-nvim
                  nvim-notify
                  project-nvim
                  actions-preview-nvim
                  which-key-nvim
                  nvim-lspconfig
                  nvim-autopairs
                  conform-nvim
                  gitsigns-nvim
                  rustaceanvim
                  go-nvim
                  hover-nvim
                  lualine-nvim
                  inputs.blink.packages.${pkgs.stdenv.hostPlatform.system}.default
                  nvim-web-devicons
                ]
                ++ pkgs.lib.mapAttrsToList (
                  pname: pin:
                  (
                    pin
                    // {
                      inherit pname;
                      version = builtins.substring 0 8 pin.revision;
                    }

                  )
                ) (pkgs.callPackages ./npins/sources.nix { });
              extraBinPath = builtins.attrValues {
                inherit (pkgs)
                  deadnix
                  statix
                  nil

                  lua-language-server
                  stylua

                  vscode-langservers-extracted
                  typos-lsp

                  go
                  gopls
                  golangci-lint
                  golangci-lint-langserver

                  fd
                  freeze
                  lazygit
                  ripgrep
                  chafa
                  ;
              };
            };
        }
      );
    };
}
