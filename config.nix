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
    local lzn = require('lz.n')
    lzn.load('lazy')
    require("mcphub").setup({
        cmd = "${inputs.mcp-hub.packages.${system}.default}/bin/mcp-hub",
        copilot = {
            enabled = true,
            convert_tools_to_functions = true,
            convert_resources_to_functions = true,
            add_mcp_prefix = false
        }
    })
    require('lzn-auto-require').enable()
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
        inherit impure;
        pure = ./nvim;
      };

    start = [
      inputs.mcphub-nvim.packages."${system}".default
    ]
    ++ inputs.mnw.lib.npinsToPlugins pkgs ./npins/required.json;

    opt = [

      inputs.blink.packages.${system}.default
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        _:
        pkgs.vimPlugins.nvim-treesitter.allGrammars
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
    ++ inputs.mnw.lib.npinsToPlugins pkgs ./npins/optional.json;
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
