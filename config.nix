{
  inputs,
  pkgs,
  system,
  ...
}:
{
  neovim = pkgs.neovim-unwrapped;

  appName = "lunavim";

  extraLuaPackages = p: [
    p.luafilesystem
  ];

  initLua = ''
    vim.loader.enable(true)
    require('lunavim')
    require('lz.n').load('lazy')
  '';

  desktopEntry = false;

  plugins = {
    # our configurations
    dev.lunavim =
      let
        homeDir =
          if pkgs.stdenv.hostPlatform.isLinux then
            "/home/tommy/Documents"
          else if pkgs.stdenv.hostPlatform.isDarwin then
            "/Users/tommy.donavon/Documents"
          else
            builtins.throw "unsupported system";
        impure = "${homeDir}/lunavim/nvim";
      in
      {
        # absolute file path to hot reload on changes
        inherit impure;
        pure = ./nvim;
      };
    # plugins we want to initialize automatically
    start = with pkgs.vimPlugins; [
      lz-n
      nvim-autopairs
      nvim-notify
      rustaceanvim
      which-key-nvim
      snacks-nvim
    ];

    # plugins we want to lazy load
    opt =
      with pkgs.vimPlugins;
      [

        inputs.blink.packages.${system}.default
        actions-preview-nvim
        conform-nvim
        gitsigns-nvim
        go-nvim
        hover-nvim
        lualine-nvim
        markdown-preview-nvim
        nvim-web-devicons
        oil-nvim
        overseer-nvim
        outline-nvim
        project-nvim
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
  };

  extraBinPath = builtins.attrValues {
    inherit (pkgs)
      deadnix
      nil
      statix

      nodejs-slim
      typos-lsp
      yaml-language-server

      fd
      freeze
      imagemagick
      lazygit
      ripgrep
      ;
  };

}
