{

  vimUtils,
  yue,
  version,
}:
vimUtils.buildVimPlugin {
  pname = "lunavim";
  inherit version;
  src = ../lunavim;
  nvimSkipModule = [
    "init"
  ];
  #  buildInputs = [ luafilesystem ];

  preInstall = ''
       mkdir -p $out/lua/lunavim
       cp -r . $out/lua/lunavim
        #yue -m -t $out/lua/lunavim .
    #    cp -r assets $out/lua/lunavim
  '';
}
