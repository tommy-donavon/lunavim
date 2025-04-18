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
                  nvim-notify
                  nvim-web-devicons
                  lz-n
                  oil-nvim
                  overseer-nvim
                  outline-nvim
                  plenary-nvim
                  project-nvim
                  rustaceanvim
                  snacks-nvim
                  which-key-nvim
                  (nvim-treesitter.withPlugins (
                    _:
                    nvim-treesitter.allGrammars
                    ++ [
                      (pkgs.tree-sitter.buildGrammar {
                        language = "blade";
                        version = "0.11.0";
                        src = pkgs.fetchFromGitHub {
                          owner = "EmranMR";
                          repo = "tree-sitter-blade";
                          rev = "a9997ceb8d2e0cd902fe649a33b476d37a0d6042";
                          sha256 = "1dfc38q9j2i1lyhzl9z1hxgsa1id7bjmhbjdjnqlz82bg6qrsc9x";

                        };
                      })
                    ]
                  ))
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
                  nil
                  statix

                  nodejs-slim
                  typos-lsp

                  fd
                  freeze
                  imagemagick
                  lazygit
                  ripgrep
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
