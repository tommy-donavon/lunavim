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
          f {
            pkgs = import nixpkgs {
              inherit system;
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
              just
              tokei
              cocogitto
              npins
              lua
              stylua
              lua53Packages.luacheck
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
          lunavim = pkgs.callPackage ./packages/lunavim.nix {
            version = builtins.substring 0 8 self.lastModifiedDate;
          };
          default =
            # based on https://github.com/Gerg-L/nvim-flake/blob/master/flake.nix#L100
            inputs.mnw.lib.wrap pkgs {
              neovim = pkgs.neovim-unwrapped;

              appName = "lunavim";

              extraLuaPackages = p: [
                p.luafilesystem
              ];

              initLua = ''
                require('lunavim')
              '';

              desktopEntry = false;

              plugins =
                with pkgs.vimPlugins;
                [
                  lunavim
                  inputs.blink.packages.${pkgs.stdenv.hostPlatform.system}.default

                  actions-preview-nvim
                  conform-nvim
                  gitsigns-nvim
                  go-nvim
                  hover-nvim
                  lualine-nvim
                  markdown-preview-nvim
                  nvim-autopairs
                  nvim-lspconfig
                  nvim-notify
                  nvim-treesitter.withAllGrammars
                  nvim-web-devicons
                  lz-n
                  oil-nvim
                  overseer-nvim
                  outline-nvim
                  plenary-nvim
                  project-nvim
                  rustaceanvim
                  snacks-nvim
                  telescope-nvim
                  which-key-nvim
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
                  imagemagick
                  ;
              };
            };
        }
      );
      overlays = {
        default = final: prev: {
          lunavim = self.packages.${prev.system}.default;
        };
      };
    };
}
